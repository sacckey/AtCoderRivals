class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.integer :epoch_second
      t.references :problem, foreign_key: true
      t.references :contest, foreign_key: true
      t.references :atcoder_user, foreign_key: true
      t.string :language
      t.float :point
      t.string :result

      t.timestamps
    end
    add_index :submissions, :epoch_second
    add_index :submissions, [:atcoder_user_id, :epoch_second]
  end
end
