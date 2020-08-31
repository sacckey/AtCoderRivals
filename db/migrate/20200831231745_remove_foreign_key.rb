class RemoveForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key "histories", "contests"
    remove_foreign_key "problems", "contests"
    remove_foreign_key "submissions", "atcoder_users"
    remove_foreign_key "submissions", "contests"
    remove_foreign_key "submissions", "problems"
    remove_foreign_key "users", "atcoder_users"
    remove_foreign_key "histories", "atcoder_users"
  end
end
