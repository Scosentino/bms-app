class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout 'admins'

  def index
    @customers = User.completed_customers
    @orders = Order.completed_orders
    @offers = current_user.admin_offers
  end

  def update_info
    if current_user.update(admin_info_params.merge({validate_main: true}))
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

  def update_logo
    if params[:user][:navbar_logo].present?
      if current_user.update!(navbar_logo: params[:user][:navbar_logo],validate_main: true)
        flash[:notice] = 'Nav bar logo successfully updated.'
      else
        flash[:alert] = current_user.errors.full_messages.first
      end
      redirect_to admins_path
    end
  end

  private

  def admin_info_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end