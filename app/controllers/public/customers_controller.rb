class Public::CustomersController < ApplicationController
  def edit
    @customer = current_customer
  end

  def my_page
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "successfuly"
      redirect_to public_customers_my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer

    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

    private
  def customer_params
    params.require(:customer).permit(:is_active, :first_name, :last_name, :first_name_kana, :email, :last_name_kana, :postal_code, :address, :telephone_number)
  end
end
