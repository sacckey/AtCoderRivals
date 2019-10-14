class AddHistoryToContest < ActiveRecord::Migration[5.2]
  def change
    add_reference :histories, :contest, foreign_key: true
  end
end
