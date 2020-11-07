class RemoveIndexFromAtcoderUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :atcoder_users, column: [:atcoder_id, :accepted_count]
    remove_index :atcoder_users, column: [:atcoder_id, :rated_point_sum]
  end
end
