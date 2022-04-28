class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = current_customer.addresses.new(address_params)
    @address.save
    redirect_to public_addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "successfuly"
      redirect_to public_addresses_path
    else
      render :edit
    end
  end
  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      flash[:notice] = "successfuly"
      redirect_to public_addresses_path
    else
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
