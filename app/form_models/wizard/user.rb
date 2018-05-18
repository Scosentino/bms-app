module Wizard
  module User
    STEPS = %w(step1 step2 step3 step4 step5).freeze

    class Base
      include ActiveModel::Model
      attr_accessor :user

      delegate *::User.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :user

      def initialize(user_attributes)
        @user = ::User.new(user_attributes)
      end
    end

    class Step1 < Base
      validates :email, presence: true, format: {
          with: /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i
      }
      PASSWORD_FORMAT = /\A
        (?=.{8,})          # Must contain 8 or more characters
        (?=.*\d)           # Must contain a digit
        (?=.*[a-z])        # Must contain a lower case character
      /x

      validates :password,
                presence: true,
                length: { in: Devise.password_length },
                format: { with: PASSWORD_FORMAT },
                confirmation: true,
                on: :create
    end

    class Step2 < Step1
      validates_presence_of :documents
    end

    class Step3 < Step2
      validates_presence_of :service_id
    end

    class Step4 < Step3
      validates :first_name, presence: true
      validates :last_name, presence: true
      validates :phone_number, presence: true
      validates :ssn, presence: true
      validates :provided_account_pin, presence: true
      validates :instructions, presence: true
      validates :date_of_birth, presence: true
    end

    class Step5 < Step4
      validates :accept_and_terms, inclusion: { in: [ true ] }
    end
  end
end