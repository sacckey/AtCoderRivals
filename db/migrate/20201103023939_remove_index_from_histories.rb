class RemoveIndexFromHistories < ActiveRecord::Migration[6.0]
  def change
    remove_index :histories, column: [:atcoder_user_id]
  end
end
