class Customers::OffersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_offer
  layout 'customers'

  def show
    if @offer.blank?
      flash[:alert] = 'Offer does not present'
      redirect_to admins_path
    end
  end

  private

  def set_offer
    @offer = Offer.find_by(id: params[:id])
  end
end