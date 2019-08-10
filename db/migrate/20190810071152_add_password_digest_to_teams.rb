class AddPasswordDigestToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :password_digest, :string
  end
end
