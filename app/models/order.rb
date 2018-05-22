class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id', dependent: :destroy
  belongs_to :business, required: false
  has_one :offer

  attr_accessor :from_main_app

  validates_presence_of :documents
  validates :accepted_policy, inclusion: { in: [ true ] }, if: :from_main_app

  enum status: %w[pending submitted rejected]

  mount_uploaders :documents, DocumentsUploader

  before_save :send_emails, if: :policy_is_accepted

  scope :completed_orders, -> { where(completed: true) }

  def status_html
    if pending?
      '<label class="offer_label_status_pending">pending</label>'
    elsif submitted?
      '<label class="offer_label_status_accepted">submitted</label>'
    elsif rejected?
      '<label class="offer_label_status_rejected">rejected</label>'
    end
  end

  def send_emails
    # Send to admins
    User.where(user_type: 'admin').pluck(:email).each do |email|
      AdminNotifierMailer.new_order(self.customer_id, self.id, email).deliver_later
    end

    # Send to customer
    CustomerNotifierMailer.new_order(self.customer_id, self.id).deliver_later
  end

  def policy_is_accepted
    accepted_policy_changed? && accepted_policy
  end
end