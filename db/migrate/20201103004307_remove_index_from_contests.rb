class RemoveIndexFromContests < ActiveRecord::Migration[6.0]
  def change
    remove_index :contests, column: [:name, :start_epoch_second]
    remove_index :contests, column: [:title, :start_epoch_second]
  end
end
