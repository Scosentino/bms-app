class ChangeOffersTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :offers, :title, :string
    remove_column :offers, :description, :text
    remove_column :offers, :bid, :float
    add_column :offers, :estimated_annual_savings, :string

    # Orders
    add_column :orders, :business_id, :bigint
    add_index :orders, :business_id
  end
end
