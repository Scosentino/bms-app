class CreateBusiness < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.bigint :customer_id, foreign_key: true
      t.string :legal_name
      t.string :dba
      t.text :address_line_1
      t.text :address_line_2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :federal_tax_id
      t.text :name_of_credit_card_processor
      t.integer :years_processor
      t.string :merchant_id_number

      t.index :customer_id
      t.timestamps null: false
    end
  end
end
