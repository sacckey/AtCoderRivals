class AddImageUrlToAtcoderUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :atcoder_users, :image_url, :string
  end
end
