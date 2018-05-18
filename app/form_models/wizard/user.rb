module Wizard
  module User
    STEPS = %w(step1 step2 step3 step4 step5).freeze

    class Base
      include ActiveModel::Model
      attr_accessor :user, :order

      delegate *::User.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :user
      delegate *::Order.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :user
      delegate *::Business.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :user
      delegate *::PaymentMethod.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :user

      def initialize(user_attributes)
        @user = ::User.new(user_attributes)
      end
    end

    class Step1 < Base
      validates :email, presence: true, format: {
          with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      }

      validates_presence_of :order
    end

    class Step2 < Step1

    end

    class Step3 < Step2
      validates_presence_of :service_id
    end

    class Step4 < Step3
      # validates :first_name, presence: true
      # validates :last_name, presence: true
      # validates :phone_number, presence: true
      # validates :ssn, presence: true
      # validates :provided_account_pin, presence: true
      # validates :instructions, presence: true
    end

    class Step5 < Step4
      # validates :accept_and_terms, inclusion: { in: [ true ] }
    end
  end
end