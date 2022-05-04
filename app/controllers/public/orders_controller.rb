class Public::OrdersController < ApplicationController
  def new
    if current_customer.cart_items.present?
      @order = Order.new
    else
      redirect_to public_cart_items_path
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])

  end
  
  def create
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.amount = cart_item.amount
        @order_detail.order_id = @order.id
        @order_detail.total_price = cart_item.item.price
        @order_detail.save
      end
      flash[:notice] = "successfuly"
      CartItem.destroy_all
      redirect_to public_orders_complete_path
    else
      render :new
    end
  end
  
  def confirm
    # @order = current_customer.orders.new
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @cart_items = CartItem.all
    @total = 0
    @order.status = 0
    if params[:order][:addressa] == "0"
      @order.zip_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:addressa] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.address = @address.address
      @order.zip_code = @address.postal_code
      @order.name = @address.name
    elsif params[:order][:addressa] == "2"
      @order.address = params[:order][:address]
      @order.zip_code = params[:order][:zip_code]
      @order.name = params[:order][:name]
    end
  end
    
  def complete
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method, :zip_code, :address, :name, :postage, :total_payment, :customer_id, :status)
  end
end
