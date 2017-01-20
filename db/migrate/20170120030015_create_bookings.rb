class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.references :rental, index: true, null: false

      t.timestamps
    end
  end
end
