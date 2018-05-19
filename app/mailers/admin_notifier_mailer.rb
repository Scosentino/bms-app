class AdminNotifierMailer < ApplicationMailer
  default from: 'BMS <support@bms_app.com>'
  before_action :set_admin_emails

  def new_order customer_id, order_id
    @customer = User.find_by(id: customer_id)

    if @customer.present?
      @order = Order.find_by(id: order_id)

      if @order.present?
        @email.each do |e|
          mail(to: e,
               subject: "#{@customer.full_name} created new Order")
        end
      end
    end
  end

  def set_admin_emails
    @email = User.where(user_type: 1).pluck(:email)
  end
end