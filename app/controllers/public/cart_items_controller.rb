class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @sum = 0
    @cart_items.each do |cart_item|
      @sum += cart_item.subtotal
    end

  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer = current_customer
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path
    else total_price
      @cart_items = CartItem.all
      render :index
    end

  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer = current_customer
    if @cart_item.destroy
      redirect_to public_cart_items_path
    else 
      @cart_items = CartItem.all
      render :index
    end
  end

  def all_delete
    CartItem.destroy_all
    redirect_to public_cart_items_path
  end

  def create
    if current_customer
      @cart_itema = CartItem.find_by(item_id: cart_item_params[:item_id], customer_id: current_customer.id)
      if @cart_itema
        amount = @cart_itema.amount + cart_item_params[:amount].to_i
        @cart_itema.update(amount: amount)
        redirect_to public_cart_items_path
      else
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer = current_customer
          if @cart_item.save
            redirect_to public_cart_items_path
          else 
            @cart_items = CartItem.all
            render :index
          end
      end
    else
      redirect_to new_customer_session_path
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
