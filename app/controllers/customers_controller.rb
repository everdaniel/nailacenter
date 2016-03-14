class CustomersController < ApplicationController
  before_filter :signed_in_user

  def index
    @customers = Customer.order(:code).paginate(page: params[:page]).search(params[:search])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:success] = "Cliente creado correctamnete"
      redirect_to customers_path
    else
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:success] = "Cliente actualizado correctamente"
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    flash[:success] = "Cliente borrado correctamente"
    redirect_to customers_path
  end

end
