class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_order, only: [:show, :success]
  layout 'customers'

  def new; end

  def create
    if current_user && current_user.customer?
      order = current_user.orders.new(order_params.merge(
          {business_id: current_user.business.id,
           customer_name: current_user.full_name,
           from_main_app: true}))
      if order.save
        flash[:notice] = 'Order saved successfully'
        redirect_to customers_order_success_path(order)
      else
        flash[:alert] = 'Order not saved. Please Ensure that you fulfilled all fields'
        render :new
      end
    else
      flash[:alert] = 'You are not customer!'
      render :new
    end
  end

  def show
    @offer = @order.offer
    if @order.blank?
      flash[:alert] = 'Order does not exist!'
      redirect_to customers_path
    end
  end

  def success
    if @order.blank?
      flash[:alert] = 'Order does not exist!'
      redirect_to customers_path
    end
  end

  def destroy

  end

  private

  def order_params
    params.require(:order).permit(:accepted_policy, {documents: []})
  end

  def set_order
    @order = current_user.orders.find_by(id: params[:id])
  end
end