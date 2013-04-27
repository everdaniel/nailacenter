class ConsignmentDetailsController < ApplicationController
  before_filter :signed_in_user

  def create
    @consignment = Consignment.find(params[:consignment_id])
    @consignment_detail = @consignment.consignment_details.new(params[:consignment])
    if @consignment_detail.save
      flash[:success] = "Producto agregado correctamente"
    else
      flash[:error] = "Error al agregar el producto"
    end
    redirect_to @consignment
  end
end