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

  def accept
    change_status('accepted')
  end

  def reject
    change_status('rejected')
  end

  private

  def change_status status
    if @offer.present?
      if @offer.update(status: status)
        if status == 'accepted'
          @offer.update(accepted_at: Time.now)
        end
        if status == 'rejected'
          @offer.update(accepted_at: nil)
        end
        @status = 200
        flash[:notice] = "Offer #{status.humanize}"
      else
        @status = 500
        flash[:alert] = "Offer does not #{status}"
      end
    else
      @status = 404
      flash[:alert] = 'Offer was not found'
    end
  end

  def set_offer
    @offer = Offer.find_by(id: params[:id])
  end
end