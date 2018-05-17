class Order < ApplicationRecord
  belongs_to :user, foreign_key: 'customer_id', dependent: :destroy

  validates_presence_of :title, :description, :document

  mount_uploader :document, DocumentsUploader
end