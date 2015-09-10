class BoletosController < ApplicationController
  before_action :set_boleto, only: [:show, :edit, :update, :destroy]

  def index
    if params[:ref] || params[:doc_number] || params[:date_begin] || params[:date_end]
      @boletos = Boleto.all
      @boletos = @boletos.joins(:client).where(clients: {ref: params[:ref].to_i}) unless params[:ref].empty?
      @boletos = @boletos.where(doc_number: params[:doc_number]) unless params[:doc_number].empty?
      @boletos = @boletos.where('maturity >= :date', date: params["date_begin"]) unless params[:date_begin].empty?
      @boletos = @boletos.where('maturity <= :date', date: params["date_end"]) unless params[:date_end].empty?
    else
      @boletos = Boleto.all
    end
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

    respond_to do |format|
      if @boleto.save
        format.html do
          flash[:success] = "Created!"
          redirect_to boletos_path
        end
        format.json { render :show, status: :created, location: @boleto }
      else
        format.html { render :new }
        format.json { render json: @boleto.errors, status: :unprocessable_entity }
      end
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
    head :no_content
  end

  private
  def set_boleto
    @boleto = Boleto.find(params[:id])
  end

  def boleto_params
    params.require(:boleto).permit(:amount, :discount, :date, :maturity, :days_to_maturity, :doc_number, :client_id)
  end
end
