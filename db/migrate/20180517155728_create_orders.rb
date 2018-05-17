class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.bigint :customer_id, foreign_key: true
      t.string :title
      t.text :description
      t.json :document

      t.index :customer_id
    end
  end
end
