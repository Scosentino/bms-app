class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout 'admins'

  def index
    @customers = User.where(user_type: 0)
    @orders = Order.where(completed: false)
    @offers = current_user.admin_offers
  end
end