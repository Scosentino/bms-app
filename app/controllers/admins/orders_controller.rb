class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'

  def show
    @order = Order.find_by(id: params[:id])

    if @order.blank?
      flash[:alert] = 'Order does not present'
      redirect_to admins_path
    end
  end
end