class RemoveAtcoderIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :atcoder_id, :string
  end
end
