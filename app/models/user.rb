class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders, foreign_key: 'customer_id'
  has_many :admin_offers, class_name: 'Offer', foreign_key: 'admin_id'
  has_many :customer_offers, class_name: 'Offer', foreign_key: 'customer_id'

  PASSWORD_FORMAT = /\A
        (?=.{8,})          # Must contain 8 or more characters
        (?=.*\d)           # Must contain a digit
        (?=.*[a-z])        # Must contain a lower case character
      /x

  validates_presence_of :first_name, :last_name
  validates :email, presence: true, format: {
      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  }
  validates :password,
            presence: true,
            length: { in: Devise.password_length },
            format: { with: PASSWORD_FORMAT },
            confirmation: true

  accepts_nested_attributes_for :orders

  enum user_type: %w[customer admin]

  def full_name
    "#{first_name.humanize} #{last_name.humanize}"
  end
end
