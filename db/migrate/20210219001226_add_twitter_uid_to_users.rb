class AddTwitterUidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_uid, :string
  end
end
