class AddStepToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :step, :integer
  end
end
