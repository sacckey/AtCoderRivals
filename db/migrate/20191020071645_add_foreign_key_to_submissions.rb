class AddForeignKeyToSubmissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :submissions, :contest_id, :integer
    remove_column :submissions, :problem_id, :integer

    add_column :submissions, :contest_name, :string
    add_column :submissions, :problem_name, :string
    add_foreign_key :submissions, :contests, column: :contest_name, primary_key: :name
    add_foreign_key :submissions, :problems, column: :problem_name, primary_key: :name
  end
end
