class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path resource
    if resource.customer?
      if !resource.completed
        redirect_to step2_wizard_path
      end
    end
  end

  def check_email
    email = params[:user_wizard].present? ? params[:user_wizard][:email] : params[:user][:email]
    if current_user.present?
      if current_user.email == email
        render json: 'true'
      else
        check_user_and_render(email)
      end
    else
      check_user_and_render(email)
    end
  end

  private

  def check_user_and_render email
    user = User.find_by(email: email)

    if user.present?
      render json: 'false'
    else
      render json: 'true'
    end
  end

  def authenticate_admin!
    redirect_application if current_user && !current_user.admin?
  end

  def non_authorized_user!
    redirect_to root_path if current_user.present? && current_user.completed
  end

  def authenticate_customer!
    redirect_application if current_user && (!current_user.customer? || !current_user.completed)
  end

  def clear_session_storage
    session[:user_attributes] = nil
    session[:payment_method_attributes] = nil
    session[:business_attributes] = nil
    session[:order_attributes] = nil
    session[:order_attributes_image] = nil
  end

  def redirect_application
    if current_user.present?
      if current_user.admin?
        redirect_to admins_path
      elsif current_user.customer?
        if current_user.completed
          redirect_to customers_path
        else
          redirect_to step2_wizard_path
        end
      end
    else
      redirect_to root_path
    end
  end
end
