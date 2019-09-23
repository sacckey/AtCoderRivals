class AddIndexToUsersUid < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :uid, unique: true
  end
end
