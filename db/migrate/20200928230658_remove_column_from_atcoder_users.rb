class RemoveColumnFromAtcoderUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :atcoder_users, :accepted_count_rank, :integer
    remove_column :atcoder_users, :rated_point_sum_rank, :integer
  end
end
