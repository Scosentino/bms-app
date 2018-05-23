class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders, foreign_key: 'customer_id', dependent: :destroy
  has_many :admin_offers, class_name: 'Offer', foreign_key: 'admin_id', dependent: :nullify
  has_many :customer_offers, class_name: 'Offer', foreign_key: 'customer_id',  dependent: :nullify
  has_one :business, foreign_key: 'customer_id', dependent: :destroy
  has_one :payment_method, foreign_key: 'customer_id', dependent: :destroy

  accepts_nested_attributes_for :orders, :reject_if => :all_blank
  accepts_nested_attributes_for :business, :reject_if => :all_blank
  accepts_nested_attributes_for :payment_method, :reject_if => :all_blank

  attr_accessor :old_password, :validate_main

  validates_presence_of :first_name, :last_name
  validates :email, presence: true, format: {
      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  }
  validates_presence_of :job_title, unless: :validate_main

  scope :completed_customers, -> { where(user_type: 0, completed: true) }

  enum user_type: %w[customer admin]

  mount_uploader :navbar_logo, NavbarLogoUploader

  def full_name
    "#{first_name.try(:humanize)} #{last_name.try(:humanize)}"
  end
end
