class Public::CartItemsController < ApplicationController
  def index
  end

  def update
  end

  def destroy
  end

  def all_delete
  end

  def create
    @cart
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
