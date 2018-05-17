class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'

  def show
    @customer = User.find_by(id: params[:id])

    if @customer.blank?
      flash[:alert] = 'Customer does not present'
      redirect_to admins_path
    end
  end
end