class Offer < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
  belongs_to :order

  enum status: %w[pending accepted rejected]

  validates_presence_of :title, :description, :bid
end