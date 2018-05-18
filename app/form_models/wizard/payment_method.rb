module Wizard
  module PaymentMethod
    class Base
      include ActiveModel::Model
      attr_accessor :payment_method

      delegate *::PaymentMethod.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :payment_method

      def initialize(user_attributes)
        @payment_method = ::PaymentMethod.new(user_attributes)
      end
    end

    class Validate < Base
      validates_presence_of :card_number, :security_code, :zipcode, :bank_account_number, if: :if_choosed_card
      validates_presence_of :bank_account_number, :bank_account_routing_number, if: :if_choosed_bank

      def if_choosed_card
        @payment_method.credit_card? || @payment_method.debit_card?
      end

      def if_choosed_bank
        @payment_method.bank_account?
      end
    end
  end
end