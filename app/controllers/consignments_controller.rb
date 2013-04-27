class ConsignmentsController < ApplicationController
  before_filter :signed_in_user

  def index
    @consignments = Consignment.includes(:supplier).paginate(page: params[:page])
  end

  def new
    @consignment = Consignment.new
    @consignment.name = "Pedido del " + Date.today.to_s
    @suppliers = Supplier.order(:name).all
  end

  def create
    @consignment = Consignment.new(params[:consignment])
    if @consignment.save
      flash[:success] = "Pedido creado correctamnete"
      redirect_to @consignment
    else
      render 'new'
    end
  end

  def edit
    @consignment = Consignment.find(params[:id])
  end

  def update
    @consignment = Consignment.find(params[:id])
    if @consignment.update_attributes(params[:consignment])
      flash[:success] = "Pedido actualizado correctamente"
      redirect_to @consignment
    else
      render 'edit'
    end
  end

  def show
    @consignment = Consignment.find(params[:id])
    @consignment_details = @consignment.consignment_details.paginate(page: params[:page])
    @products = Product.order(:short_name).search(params[:search]) if !params[:search].blank?
  end

  def destroy
    Consignment.find(params[:id]).destroy
    flash[:success] = "Pedido borrado correctamente"
    redirect_to consignments_path
  end

end