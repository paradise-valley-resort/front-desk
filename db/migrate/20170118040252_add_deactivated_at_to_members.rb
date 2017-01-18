class AddDeactivatedAtToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :deactivated_at, :datetime
  end
end
