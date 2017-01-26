class AddAmenitiesToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :accommodates, :integer, default: 0, null: false
    add_column :rentals, :air_conditioning, :boolean, default: false
    add_column :rentals, :bathrooms, :integer, default: 0, null: false
    add_column :rentals, :bedrooms, :integer, default: 0, null: false
    add_column :rentals, :beds, :integer, default: 0, null: false
    add_column :rentals, :heating, :boolean, default: false
    add_column :rentals, :internet, :boolean, default: false
    add_column :rentals, :pets, :boolean, default: false
    add_column :rentals, :refrigerator, :boolean, default: false
    add_column :rentals, :shower, :boolean, default: false
    add_column :rentals, :smoking, :boolean, default: false
    add_column :rentals, :stove, :boolean, default: false
    add_column :rentals, :toilet, :boolean, default: false
    add_column :rentals, :tv, :boolean, default: false
  end
end
