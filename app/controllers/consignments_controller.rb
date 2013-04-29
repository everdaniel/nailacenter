class ConsignmentsController < ApplicationController
  before_filter :signed_in_user

  def index
    @consignments = Consignment.includes(:supplier).paginate(page: params[:page])
  end

  def new
    @consignment = Consignment.new
    @consignment.name = "Pedido del " + Date.today.to_s
    3.times { @consignment.consignment_details.build }
  end

  def create
    @consignment = Consignment.new(params[:consignment])
    if @consignment.save
      flash[:success] = "Pedido creado correctamente"
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
  end

  def destroy
    Consignment.find(params[:id]).destroy
    flash[:success] = "Pedido borrado correctamente"
    redirect_to consignments_path
  end

  def receive
    @consignment = Consignment.find(params[:consignment_id])
    if @consignment.status == 6
      flash[:warning] = "El pedido ya se ha recibido"
      redirect_to consignments_path
    end
  end

  def receive_update
    @consignment = Consignment.find(params[:consignment_id])
    
    if @consignment.status == 6
      flash[:warning] = "El pedido ya se ha recibido"
      redirect_to consignments_path
    end

    if !params[:receive].empty?
      params[:receive].each do |detail|
        detail = detail[1]
        cost = detail["cost"].to_f
        price = detail["price"].to_f
        if price < cost
          flash[:success] = "Verifique que los precios son mayores al costo de compra"
          redirect_to consignment_receive_path(@consignment)
        end
      end
      params[:receive].each do |detail|
        # get shit
        detail = detail[1]
        product_id = detail["id"]
        quantity = detail["quantity"]
        cost = detail["cost"]
        price = detail["price"]

        # Find shit
        product = Product.find(product_id)
        stock = Stock.find_by_product_id_and_cost(product_id, cost)

        # update shit
        if !stock.nil?
          stock.quantity += quantity.to_f
          stock.save
        else
          new_stock = product.stocks.new
          new_stock.cost = cost
          new_stock.price = price
          new_stock.quantity = quantity
          new_stock.save
        end
      end
      @consignment.status = 6
      @consignment.save
    end
    redirect_to consignments_path
  end
end