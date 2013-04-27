class ProductsController < ApplicationController
  before_filter :signed_in_user

  def index
    @products = Product.order(:short_name).paginate(page: params[:page]).search(params[:search])
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    @product.is_active = true
    if @product.save
      flash[:success] = "Producto creado correctamnete"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:success] = "Producto actualizado correctamente"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Producto borrado correctamente"
    redirect_to products_path
  end

end