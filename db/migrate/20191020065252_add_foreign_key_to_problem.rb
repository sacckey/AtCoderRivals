class AddForeignKeyToProblem < ActiveRecord::Migration[5.2]
  def change
    remove_column :problems, :contest_id, :integer

    add_column :problems, :contest_name, :string
    add_foreign_key :problems, :contests, column: :contest_name
  end
end
