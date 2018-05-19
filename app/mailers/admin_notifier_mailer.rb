class AdminNotifierMailer < ApplicationMailer
  include WickedPdf::PdfHelper
  default from: 'BMS <support@bms_app.com>'
  before_action :set_admin_emails

  def new_order customer_id, order_id
    @customer = User.find_by(id: customer_id)

    if @customer.present?
      @order = Order.find_by(id: order_id)

      if @order.present?
        pdf = render_to_string_with_wicked_pdf(
            pdf: 'merchant_agreement',
            :template => 'generate_contracts/merchant_agreement',
            :locals => {:@model => @order, :@customer => @customer },
            :margin => { :bottom => 10 },
            :footer => { :html => { :template => 'generate_contracts/footer', :locals => {:@model => @order, :@customer => @customer }} }
        )
        attachments["merchant_agreement_#{@order.id}.pdf"] = pdf

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