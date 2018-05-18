module Wizard
  module Order
    class Base
      include ActiveModel::Model
      attr_accessor :order

      delegate *::Order.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :order

      def initialize(user_attributes)
        @order = ::Order.new(user_attributes)
      end
    end

    class Validate < Base
      validates_presence_of :documents
    end

    class Acceptance < Validate
      validates :accept_and_terms, inclusion: { in: [ true ] }
    end
  end
end