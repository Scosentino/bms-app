class ChangesInTables < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :provide_account_pin
    add_column :users, :job_title, :string
  end
end
