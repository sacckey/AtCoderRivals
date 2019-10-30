class AddSubmissionNumberToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :number, :integer
    add_index  :submissions, :number, unique: true
  end
end
