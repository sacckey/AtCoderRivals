class RemoveIndexFromProblems < ActiveRecord::Migration[6.0]
  def change
    remove_index :problems, name: :index_problems_on_contest_id_and_name
  end
end
