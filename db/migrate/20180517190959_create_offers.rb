class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.bigint :customer_id, foreign_key: true
      t.bigint :admin_id, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.string :title
      t.text :description
      t.integer :status, default: 0
      t.float :bid

      t.timestamps null: false

      t.index :customer_id
      t.index :admin_id
    end
  end
end
