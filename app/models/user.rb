class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: %w[customer admin]

  has_many :orders, foreign_key: 'customer_id'
  has_many :admin_offers, class_name: 'Offer', foreign_key: 'admin_id'
  has_many :customer_offers, class_name: 'Offer', foreign_key: 'customer_id'

  validates_presence_of :first_name, :last_name, :email

  def full_name
    "#{first_name.humanize} #{last_name.humanize}"
  end
end
