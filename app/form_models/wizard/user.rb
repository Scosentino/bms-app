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
          with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      }
    end

    class Step2 < Step1; end

    class Step3 < Step2
      validates_presence_of :first_name, :last_name, :phone_number, :ssn, :job_title
    end

    class Step4 < Step3; end

    class Step5 < Step4; end
  end
end