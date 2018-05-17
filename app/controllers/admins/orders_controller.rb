class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order
  layout 'admins'

  def show
    if @order.blank?
      flash[:alert] = 'Order does not present'
      redirect_to admins_path
    else
      @order.update(reviewed: true) unless @order.reviewed
    end
  end

  def submit
    change_status('submitted')
  end

  def reject
    change_status('rejected')
  end

  private

  def change_status status
    if @order.present?
      if @order.update(status: status)
        @status = 200
        flash[:notice] = "Order #{status.humanize}"
      else
        @status = 500
        flash[:alert] = "Order does not #{status}"
      end
    else
      @status = 404
      flash[:alert] = 'Order was not found'
    end
  end

  def set_order
    @order = Order.find_by(id: params[:id])
  end
end