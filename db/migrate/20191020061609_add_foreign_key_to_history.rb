class AddForeignKeyToHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :histories, :contest_id, :integer

    add_column :histories, :contest_title, :string, index: true
    add_foreign_key :histories, :contests, column: :contest_title, primary_key: :title
  end
end
