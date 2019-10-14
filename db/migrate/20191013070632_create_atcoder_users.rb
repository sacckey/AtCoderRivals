class CreateAtcoderUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :atcoder_users do |t|
      t.string :atcoder_id
      t.integer :accepted_count
      t.integer :accepted_count_rank
      t.float :rated_point_sum
      t.integer :rated_point_sum_rank

      t.timestamps
    end
    add_index :atcoder_users, :atcoder_id, unique: true
    add_index :atcoder_users, :accepted_count
    add_index :atcoder_users, :rated_point_sum
    add_index :atcoder_users, [:atcoder_id, :accepted_count]
    add_index :atcoder_users, [:atcoder_id, :rated_point_sum]
  end
end
