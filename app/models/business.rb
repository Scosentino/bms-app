class Business < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  has_one :order

  validates_presence_of :legal_name, :dba, :address_line_1, :address_line_2, :city, :state, :zipcode,
                        :federal_tax_id, :name_of_credit_card_processor, :years_processor,
                        :merchant_id_number
end