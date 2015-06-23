class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:edit, :update, :destroy]

  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def edit
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      flash[:success] = "Saved!"
      redirect_to suppliers_path
    else
      flash[:fail] = "Fail!"
      render :new
    end
  end

  def update
    if @supplier.update(supplier_params)
      flash[:success] = "Updated!"
      redirect_to suppliers_path
    else
      flash[:fail] = "Fail!"
      render :new
    end
  end

  def destroy
    @supplier.destroy
    flash[:fail] = "Destroyed!"
    redirect_to supplier_path
  end

  private
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    def supplier_params
      params.require(:supplier).permit(:name, :contact, :email, :phone)
    end
end
