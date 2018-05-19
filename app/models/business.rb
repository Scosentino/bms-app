class Business < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  has_one :order

  validates_presence_of :legal_name, :address_line_1, :city, :state, :zipcode,
                        :federal_tax_id, :name_of_credit_card_processor, :years_processor,
                        :merchant_id_number

  def get_name
    if legal_name.present?
      legal_name
    else
      dba
    end
  end
end