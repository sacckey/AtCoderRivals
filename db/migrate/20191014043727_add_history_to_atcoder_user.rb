class AddHistoryToAtcoderUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :histories, :atcoder_user, foreign_key: true
  end
end
