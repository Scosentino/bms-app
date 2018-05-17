class AddColumnsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :reviewed, :boolean, default: false
    add_column :orders, :status, :integer, default: 0
  end
end
