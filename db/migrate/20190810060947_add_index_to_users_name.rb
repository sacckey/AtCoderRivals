class AddIndexToUsersName < ActiveRecord::Migration[5.2]
  def change
    add_index :teams, :name, unique: true
  end
end
