class AddIndexToUsersTwitterUid < ActiveRecord::Migration[6.0]
  def change
    add_index  :users, :twitter_uid, unique: true
  end
end
