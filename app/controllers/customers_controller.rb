class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_customer!

  def index
    @orders = current_user.orders
    @offers = current_user.customer_offers
  end

  def update_info
    if current_user.update(customer_info_params.merge({validate_main: true}))
      flash[:notice] = 'Updated successfully'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to admins_path
  end

  def update_password
    if current_user.valid_password?(params[:user][:old_password])
      user = current_user
      current_user.update(password: params[:user][:password], validate_main: true)
      bypass_sign_in(user)
      flash[:notice] = 'Password successfully updated.'
    else
      flash[:alert] = 'Old password is incorrect.'
    end
    redirect_to admins_path
  end

  def update_business
    business = params[:business][:id].present? ? Business.find_by(id: params[:business][:id]) : Business.new(business_params.merge({customer_id: current_user.id}))
    business.save
    if business.update(business_params)
      flash[:notice] = 'Business updated'
    else
      flash[:alert] = 'Something went wrong'
    end

    redirect_to customers_path
  end

  private

  def customer_info_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def business_params
    params.require(:business).permit(:legal_name, :address_line_1, :city, :state, :zipcode, :federal_tax_id, :name_of_credit_card_processor,
                                 :years_processor, :merchant_id_number, :dba, :address_line_2)
  end

  def payment_method_params
    params.require(:payment_method).permit(:card_number, :security_code, :zipcode, :bank_account_number, :bank_account_routing_number, :payment_type,
                            :bank_name, :year_ended, :month_ended)
  end
end