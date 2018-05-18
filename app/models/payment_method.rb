class PaymentMethod < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'

  enum payment_type: %w[debit_card credit_card bank_account]

  validates_presence_of :card_number, :security_code, :zipcode, :bank_account_number, if: :payment_type == 'debit_card' || :payment_type == 'credit_card'
  validates_presence_of :bank_account_number, :bank_account_routing_number, if: :payment_type == 'bank_account'
end