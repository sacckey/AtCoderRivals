class RemoveAtcoderIdFromHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :histories, :atcoder_id, :string
    remove_column :histories, :contest_name, :string
  end
end
