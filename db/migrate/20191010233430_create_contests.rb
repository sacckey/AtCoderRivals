class CreateContests < ActiveRecord::Migration[5.2]
  def change
    create_table :contests do |t|
      t.string :abbreviation
      t.integer :start_epoch_second
      t.integer :duration_second
      t.string :title
      t.string :rate_change

      t.timestamps
    end
    add_index :contests, :start_epoch_second
  end
end
