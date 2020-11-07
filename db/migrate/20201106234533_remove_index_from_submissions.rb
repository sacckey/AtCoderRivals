class RemoveIndexFromSubmissions < ActiveRecord::Migration[6.0]
  def change
    remove_index :submissions, column: [:atcoder_user_id]
  end
end
