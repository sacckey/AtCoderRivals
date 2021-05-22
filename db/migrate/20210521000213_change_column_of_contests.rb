class ChangeColumnOfContests < ActiveRecord::Migration[6.0]
  def up
    change_column :contests, :start_epoch_second, :bigint
    change_column :contests, :duration_second, :bigint
  end

  def down
    change_column :contests, :start_epoch_second, :integer
    change_column :contests, :duration_second, :integer
  end
end
