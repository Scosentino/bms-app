class PaymentMethod < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'

  enum payment_type: %w[debit_card credit_card bank_account]

  validates_presence_of :card_number, :security_code, :zipcode, :bank_account_number, if: :if_choosed_card
  validates_presence_of :bank_account_number, :bank_account_routing_number, if: :if_choosed_bank

  def if_choosed_card
    credit_card? || debit_card?
  end

  def if_choosed_bank
    bank_account?
  end
end