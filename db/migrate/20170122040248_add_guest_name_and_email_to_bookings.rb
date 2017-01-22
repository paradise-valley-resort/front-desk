class AddGuestNameAndEmailToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :guest_name, :string, limit: 255, null: false
    add_column :bookings, :guest_email, :string, limit: 255, null: false
    add_column :bookings, :guest_membership_id, :string, limit: 255
  end
end
