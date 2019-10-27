class AddRatingToAtcoderUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :atcoder_users, :rating, :integer
  end
end
