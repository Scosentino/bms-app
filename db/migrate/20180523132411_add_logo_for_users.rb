class AddLogoForUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :navbar_logo, :json
  end
end
