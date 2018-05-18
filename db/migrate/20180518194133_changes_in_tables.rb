class ChangesInTables < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :provide_account_pin, :string
    remove_column :users, :date_of_birth, :date
    add_column :users, :job_title, :string
  end
end
