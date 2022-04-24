class Public::AddressController < ApplicationController
  def index
    @addresses = current_customer.addresses
  end

  def edit
  end
end
