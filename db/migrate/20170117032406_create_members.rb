class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :first_name, limit: 255, null: false
      t.string :last_name, limit: 255, null: false
      t.string :address_1, limit: 255, null: false
      t.string :address_2, limit: 255
      t.string :city, limit: 255, null: false
      t.string :state, limit: 255, null: false
      t.string :zip_code, limit: 255, null: false
      t.string :phone, limit: 255
      t.string :email, limit: 255
      t.string :membership_id, limit: 255, null: false

      t.timestamps
    end

    add_index :members, :membership_id, unique: true
  end
end
