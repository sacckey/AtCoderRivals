class AddPointToProblem < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :point, :float

    add_index :problems, :point
  end
end
