class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def index
    @plans = Plan.all
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
      redirect_to plans_url, notice: 'Plan was successfully updated.'
    else
      redirect_to plans_url, notice: 'Fail.'
    end
  end

  def destroy
    @plan.destroy
    redirect_to plans_url, notice: 'Plan was successfully destroyed.'
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plan_params
      params.require(:plan).permit(:date,
                                   :station_id,
                                   measures_attributes: [:id, :final_volume, :buy_volume]
      )
    end
end
