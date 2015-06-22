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
      flash[:success] = "Saved!"
      redirect_to stations_path
    else
      flash[:fail] = "Fail!"
      render :index
    end
  end

  def update
    if @station.update(station_params)
      flash[:success] = "Updated!"
      redirect_to stations_path
    else
      flash[:fail] = "Fail!"
      render :edit
    end
  end

  def destroy
    @station.destroy
    flash[:fail] = "Destroyed!"
    redirect_to stations_url
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
