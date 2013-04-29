class ProductsController < ApplicationController
  before_filter :signed_in_user

  def index
    search_query = params[:search] || params[:term]
    @products = Product.order(:short_name).paginate(page: params[:page]).search(search_query)

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render :json => @products.map(&:short_name) }
      format.json { render :json => @products.to_json(:only => [ :short_name, :id]) }
      format.xml { render :json => @products }
    end
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