class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.json :image

      t.timestamps null: false
    end
  end
end
