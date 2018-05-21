class ChangeZipcodeForPayments < ActiveRecord::Migration[5.1]
  def change
    change_column :payment_methods, :zipcode, :string
  end
end
