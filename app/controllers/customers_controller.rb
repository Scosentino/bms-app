class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_customer!

  def index
    @orders = current_user.orders
    @offers = current_user.customer_offers
  end
end