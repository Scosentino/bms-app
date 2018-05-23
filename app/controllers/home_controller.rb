class HomeController < ApplicationController
  layout 'application'

  def index
    if current_user.present?
      if current_user.admin?
        redirect_to admins_path
      elsif current_user.customer?
        redirect_to customers_path
      end
    end
  end
end