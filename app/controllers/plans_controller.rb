class PlansController < ApplicationController
  before_action :set_plan, only: [:edit, :update, :destroy]

  def index
    if params[:begin_date] && params[:begin_date]
      @plans = Plan.between_dates(params[:begin_date], params[:end_date])
    else
      @plans = Plan.order('date DESC').limit(10)
    end
  end

  def measures
    @plans = Plan.where(finished: false).order('station_id, date')
  end

  def forecast
    @plans = Plan.where(finished: false).order('station_id, date')
  end

  def buy
    @plans = Plan.where(finished: false).order('station_id, date')
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
    if @plan.update(plan_params)
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

    def plan_params
      params.require(:plan).permit(:date,
                                   :station_id,
                                   measures_attributes: [:id, :final_volume, :buy_volume, :forecast_volume]
      )
    end
end
