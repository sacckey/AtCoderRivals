class RemoveIndexInContests < ActiveRecord::Migration[5.2]
  def change
    # remove_index :problems, column: :name, name: :index_problems_on_contest_id_and_problem_name
  end
end
