class ChangeColumnOfAtcoderUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :atcoder_users, :atcoder_id, :string, null: false
    change_column :atcoder_users, :accepted_count, :integer, null: false, default: 0
    change_column :atcoder_users, :rated_point_sum, :float, null: false, default: 0.0
    change_column :atcoder_users, :image_url, :string, null: false, default: "https://img.atcoder.jp/assets/icon/avatar.png"
    change_column :atcoder_users, :rating, :integer, null: false, default: 0
  end
end
