class RenameAbbreviationColumnToContests < ActiveRecord::Migration[5.2]
  def change
    rename_column :contests, :abbreviation, :name

    rename_column :problems, :problem_name, :name
    rename_column :problems, :problem_title, :title
  end
end
