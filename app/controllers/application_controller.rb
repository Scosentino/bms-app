class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def authenticate_admin!
    redirect_application if current_user && !current_user.admin?
  end

  def authenticate_customer!
    redirect_application if current_user && !current_user.customer?
  end

  def redirect_application
    if current_user.present?
      if current_user.admin?
        redirect_to admins_path
      elsif current_user.customer?
        redirect_to customers_path
      end
    else
      redirect_to root_path
    end
  end
end
