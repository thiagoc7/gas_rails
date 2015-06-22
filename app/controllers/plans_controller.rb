class PlansController < ApplicationController
  before_action :set_plan, only: [:edit, :update, :destroy]
  before_action :set_plans, only: [:measures, :forecast, :buy]

  def index
    if params[:begin_date] && params[:end_date]
      @plans = Plan.between_dates(params[:begin_date], params[:end_date]).order('date DESC')
    else
      @plans = Plan.order('date DESC').limit(10)
    end
  end

  def measures
    redirect_to forecast_plans_url if @plans.empty?
  end

  def forecast
    @plans = Plan.create_next_plans if @plans.empty?
  end

  def buy
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to plans_url, notice: 'Plan was successfully created.'
    else
      redirect_to plans_url, notice: 'Fail.'
    end
  end

  def update
    if @plan.update(calculated_params)
      redirect_to update_redirect, notice: 'Plan was successfully updated.'
    else
      redirect_to update_redirect, notice: 'Fail.'
    end
  end

  def destroy
    @plan.destroy
    redirect_to plans_url, notice: 'Plan was successfully destroyed.'
  end

  private
    def update_redirect
      return plans_url unless params[:redirect_to]

      if params[:redirect_to][:measures]
        measures_plans_url
      elsif params[:redirect_to][:forecast]
        forecast_plans_url
      elsif params[:redirect_to][:buy]
        buy_plans_url
      else
        plans_url
      end
    end

    def set_plan
      @plan = Plan.find(params[:id])
      @plan.finished = true if params[:redirect_to] && params[:redirect_to][:measures]
    end

    def set_plans
      if params[:add_plan]
        @plans = Plan.create_next_plans
      elsif params[:begin_date] && params[:end_date]
        @plans = Plan.create_plans_for_all(params[:begin_date], params[:end_date])
      else
        @plans = Plan.open_plans
      end

    end

    def plan_params
      params.require(:plan).permit(:date,
                                   :station_id,
                                   :finished,
                                   measures_attributes: [:id, :final_volume, :buy_volume, :forecast_volume]
      )
    end

    def calculated_params
      result = plan_params
      result[:measures_attributes].each do |measure|
        next unless measure[1][:final_volume]
        if (volume = measure[1][:final_volume]).chr == '='
          volume[0] = ''
          measure[1][:final_volume] = volume.split('+').map { |v| v.to_i }.sum
        end
      end
      result
    end
end
