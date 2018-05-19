class AddForgottenFields < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_methods, :year_ended, :string
    add_column :payment_methods, :month_ended, :string
    add_column :payment_methods, :bank_name, :string
  end
end
