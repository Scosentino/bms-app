class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.bigint :customer_id, foreign_key: true
      t.string :title
      t.text :description
      t.json :documents
      t.boolean :accept_and_terms, default: false

      t.index :customer_id

      t.timestamps null: false
    end
  end
end
