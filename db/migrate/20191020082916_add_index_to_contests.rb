class AddIndexToContests < ActiveRecord::Migration[5.2]
  def change
    add_index :contests, [:title, :start_epoch_second], unique: true
    add_index :contests, [:name, :start_epoch_second], unique: true
  end
end
