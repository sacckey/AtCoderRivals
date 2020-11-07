class RemoveIndexFromRelationships < ActiveRecord::Migration[6.0]
  def change
    remove_index :relationships, column: [:follower_id]
  end
end
