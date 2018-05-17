class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User',foreign_key: 'customer_id', dependent: :destroy

  validates_presence_of :title, :description, :documents, :accept_and_terms

  mount_uploaders :documents, DocumentsUploader
end