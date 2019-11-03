class AddIndexToHistories < ActiveRecord::Migration[5.2]
  def change
    add_index :histories, [:atcoder_user_id, :contest_name], unique: true
  end
end
