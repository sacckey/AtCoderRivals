class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.string :problem_name
      t.string :problem_title
      t.references :contest, foreign_key: true

      t.timestamps
    end
    add_index :problems, [:contest_id,:problem_name]
  end
end
