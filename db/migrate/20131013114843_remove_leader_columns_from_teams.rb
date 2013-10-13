class RemoveLeaderColumnsFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :leader, :boolean
    remove_column :teams, :leader_of_team, :integer
  end
end
