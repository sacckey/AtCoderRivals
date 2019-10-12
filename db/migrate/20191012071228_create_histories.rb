class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.string :atcoder_id
      t.boolean :is_rated
      t.integer :place
      t.integer :old_rating
      t.integer :new_rating
      t.integer :performance
      t.integer :inner_performance
      t.string :contest_screen_name
      t.string :contest_name
      t.string :end_time

      t.timestamps
    end
    add_index :histories, :atcoder_id
    add_index :histories, :contest_name
    add_index :histories, [:atcoder_id, :contest_name], unique: true
  end
end
