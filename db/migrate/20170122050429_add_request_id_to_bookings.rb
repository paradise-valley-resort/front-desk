class AddRequestIdToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :request_id, :string, limit: 255, null: false
  end
end
