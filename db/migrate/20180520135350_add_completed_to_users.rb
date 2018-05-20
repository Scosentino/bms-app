class AddCompletedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :completed, :boolean, default: false
  end
end
