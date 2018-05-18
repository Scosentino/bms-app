class ChangeOffersTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :offers, :title
    remove_column :offers, :description
    remove_column :offers, :bid
    add_column :offers, :estimated_annual_savings, :string
  end
end
