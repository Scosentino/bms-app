class ChangeOrdersTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :instructions, :text
    rename_column :orders, :accept_and_terms, :accepted_policy
  end
end
