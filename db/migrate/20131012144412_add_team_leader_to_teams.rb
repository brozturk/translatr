class AddTeamLeaderToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :leader, :boolean
    add_column :teams, :leader_of_team, :integer
  end
end
