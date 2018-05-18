class CreatePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_methods do |t|
      t.bigint :customer_id, foreign_key: true
      t.integer :payment_type
      t.string :card_number
      t.integer :security_code
      t.integer :zipcode
      t.string :bank_account_number
      t.string :bank_account_routing_number

      t.index :customer_id
      t.timestamps null: false
    end
  end
end
