class StationsController < ApplicationController
  before_action :set_station

  def index
    @stations = Station.all
  end

  def edit
    @stations = Station.all
    render :index
  end

  def create
    @station = Station.new(station_params)

    if @station.save
      redirect_to stations_path, notice: 'Station was successfully created.'
    else
      render :index, notice: 'Could Not Create.'
    end
  end

  def update
    if @station.update(station_params)
      redirect_to stations_path, notice: 'Station was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @station.destroy
    redirect_to stations_url, notice: 'Station was successfully destroyed.'
  end

  private
    def set_station
      if params[:id]
        @station = Station.find(params[:id])
      else
        @station = Station.new
      end
    end

    def station_params
      params.require(:station).permit(:name)
    end
end
