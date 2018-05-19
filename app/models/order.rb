class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id', dependent: :destroy
  belongs_to :business, required: false

  validates_presence_of :documents
  validates :accepted_policy, inclusion: { in: [ true ] }

  enum status: %w[pending submitted rejected]

  mount_uploaders :documents, DocumentsUploader

  def status_html
    if pending?
      '<label class="offer_label_status_pending">pending</label>'
    elsif submitted?
      '<label class="offer_label_status_accepted">submitted</label>'
    elsif rejected?
      '<label class="offer_label_status_rejected">rejected</label>'
    end
  end
end