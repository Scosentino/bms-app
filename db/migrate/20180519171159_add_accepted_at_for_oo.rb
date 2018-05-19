class AddAcceptedAtForOo < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :accepted_at, :datetime
    add_column :offers, :accepted_at, :datetime
  end
end
