class AddReferenceToUsersAtcoderId < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :atcoder_user, foreign_key: true
  end
end
