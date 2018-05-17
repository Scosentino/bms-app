class Admins::OffersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'

  def new
    @order = Order.find_by(id: params[:order_id])

    if @order.blank?
      flash[:alert] = 'Order does not present'
      redirect_to admins_path
    end
  end

  def create
    if current_user && current_user.admin?
      offer = current_user.admin_offers.create(offer_params)
      if offer.save
        flash[:notice] = 'Offer successfully saved'
        redirect_to admins_offer_path(offer)
      else
        flash[:alert] = 'You does not admin!'
        render :new, params: {order_id: offer_params[:order_id]}
      end
    else
      flash[:alert] = 'You does not admin!'
      redirect_to admins_path
    end
  end

  def show
    @offer = Offer.find_by(id: params[:id])

    if @offer.blank?
      flash[:alert] = 'Offer does not present'
      redirect_to admins_path
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :customer_id, :order_id, :description, :bid)
  end
end