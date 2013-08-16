class SuppliersController < ApplicationController
  before_filter :signed_in_user

  def index
    @suppliers = Supplier.order(:name).paginate(page: params[:page]).search(params[:search])
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      flash[:success] = "Proveedor creado correctamnete"
      redirect_to suppliers_path
    else
      render 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:success] = "Proveedor actualizado correctamente"
      redirect_to @supplier
    else
      render 'edit'
    end
  end

  def destroy
    Supplier.find(params[:id]).destroy
    flash[:success] = "Proveedor borrado correctamente"
    redirect_to suppliers_path
  end
end