class ChangeZipcodeColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :businesses, :zipcode, :string
  end
end
