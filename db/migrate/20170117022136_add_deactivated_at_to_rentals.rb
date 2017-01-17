class AddDeactivatedAtToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :deactivated_at, :datetime
  end
end
