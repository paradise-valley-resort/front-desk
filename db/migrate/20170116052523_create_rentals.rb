class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.string :name, limit: 255, null: false
      t.text :description

      t.timestamps
    end
  end
end
