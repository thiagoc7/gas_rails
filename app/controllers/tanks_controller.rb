class TanksController < ApplicationController
  before_action :set_station
  before_action :set_tank, only: [:new, :edit, :update, :destroy]

  def index
    @tanks = @station.tanks
  end

  def new
  end

  def edit
  end

  def import
    Measure.import(params[:file], params[:station_id], params[:gasoline])
    redirect_to station_tanks_path, notice: 'Imported'
  end

  def create
    @tank = @station.tanks.create(tank_params)

    if @tank.save
      redirect_to station_tanks_path, notice: 'Tank was successfully created.'
    else
      render :new
    end
  end

  def update
    if @tank.update(tank_params)
      redirect_to station_tanks_path, notice: 'Tank was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tank.destroy
    redirect_to station_tanks_url, notice: 'Tank was successfully destroyed.'
  end

  private
    def set_station
      @station = Station.find(params[:station_id])
    end

    def set_tank
      if params[:id]
        @tank = @station.tanks.find(params[:id])
      else
        @tank = @station.tanks.build
      end
    end

    def tank_params
      params.require(:tank).permit(:gasoline, :capacity, :min_volume, :max_volume)
    end
end
