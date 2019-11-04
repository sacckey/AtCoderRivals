class AddEtagToAtcoderUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :atcoder_users, :etag, :string, default: ""
  end
end
