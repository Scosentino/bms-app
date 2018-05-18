class ChangeDatabaseColumns < ActiveRecord::Migration[5.1]
  def change
    # Orders
    remove_column :orders, :title, :string
    rename_column :orders, :description, :instructions
    add_column :orders, :service_id, :bigint
    add_index :orders, :service_id

    # Users
    add_column :users, :phone_number, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :ssn, :integer
    add_column :users, :provide_account_pin, :string
  end
end
