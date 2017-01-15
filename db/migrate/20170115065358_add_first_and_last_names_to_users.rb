class AddFirstAndLastNamesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string, limit: 255, null: false
    add_column :users, :last_name, :string, limit: 255, null: false
  end
end
