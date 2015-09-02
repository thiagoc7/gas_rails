class BoletosController < ApplicationController
  before_action :set_boleto, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
    @boletos = Boleto.all
  end

  def new
    @boleto = Boleto.new
  end

  def generate
    @boleto = Boleto.find(params[:format])
    send_data @boleto.to_b.to(:pdf), :filename => "boleto_#{params[:format]}.#{:pdf}"
  end

  def edit
  end

  def create
    @boleto = Boleto.new(boleto_params)

    if @boleto.save
      flash[:success] = "Created!"
      redirect_to boletos_path
    else
      render :new
    end
  end

  def update
    if @boleto.update(boleto_params)
      flash[:success] = "Updated!"
      redirect_to boletos_path
    else
      render :edit
    end
  end

  def destroy
    @boleto.destroy
    flash[:fail] = "Destroyed!"
    redirect_to boletos_path
  end

  private
  def set_boleto
    @boleto = Boleto.find(params[:id])
  end

  def boleto_params
    params.require(:boleto).permit(:amount, :discount, :date, :maturity, :days_to_maturity, :doc_number)
  end
end
