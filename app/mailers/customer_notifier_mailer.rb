class CustomerNotifierMailer < ApplicationMailer
  default from: 'BMS <support@bms_app.com>'

  def new_order customer_id, order_id
    @customer = User.find_by(id: customer_id)

    if @customer.present?
      @order = Order.find_by(id: order_id)

      if @order.present?
        mail(to: @customer.email,
             subject: "Order successfully created")
      end
    end
  end

  def new_offer customer_id, offer_id
    @customer = User.find_by(id: customer_id)

    if @customer.present?
      @offer = Offer.find_by(id: offer_id)

      if @offer.present?
        mail(to: @customer.email,
             subject: "You have received new offer")
      end
    end
  end
end