class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout 'admins'

  def index
    @customers = User.completed_customers
    @orders = Order.where(completed: false)
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

  private

  def admin_info_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end