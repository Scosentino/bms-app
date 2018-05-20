class Offer < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
  belongs_to :order

  enum status: %w[pending offer_sent active rejected]

  validates_presence_of :estimated_annual_savings

  after_commit :send_email, on: :create

  def status_html
    if pending?
      '<label class="offer_label_status_pending">pending</label>'
    elsif offer_sent?
      '<label class="offer_label_status_pending">offer sent</label>'
    elsif active?
      '<label class="offer_label_status_accepted">active</label>'
    elsif rejected?
      '<label class="offer_label_status_rejected">rejected</label>'
    end
  end

  def estimated_year_savings
    (estimated_annual_savings.to_f * 12).round(2)
  end

  def send_email
    CustomerNotifierMailer.new_offer(self.customer_id, self.id).deliver_later
  end
end