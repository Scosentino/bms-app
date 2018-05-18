module Wizard
  module Business
    class Base
      include ActiveModel::Model
      attr_accessor :business

      delegate *::Business.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :business

      def initialize(user_attributes)
        @business = ::Business.new(user_attributes)
      end
    end

    class Validate < Base
      validates_presence_of :legal_name, :address_line_1, :city, :state, :zipcode,
                            :federal_tax_id, :name_of_credit_card_processor, :years_processor,
                            :merchant_id_number
    end
  end
end