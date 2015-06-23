class PricesController < ApplicationController
  before_action :set_price
  before_action :set_prices, only: [:index, :edit]

  def index
  end

  def edit
    render :index
  end

  def create
    @price = Price.new(price_params)

    if @price.save
      flash[:success] = "Saved!"
      redirect_to prices_path
    else
      flash[:fail] = "Fail!"
      render :new
    end
  end

  def update
    if @price.update(price_params)
      flash[:success] = "Updated!"
      redirect_to prices_path
    else
      flash[:fail] = "Fail!"
      render :new
    end
  end

  def destroy
    @price.destroy
    flash[:fail] = "Destroyed!"
    redirect_to prices_path
  end

  private
    def set_price
      if params[:id]
        @price = Price.find(params[:id])
      else
        @price = Price.new
      end
    end

  def set_prices
    @prices = Price.includes(:supplier).all
  end

    def price_params
      params.require(:price).permit(:gasoline, :amount, :supplier_id)
    end
end
