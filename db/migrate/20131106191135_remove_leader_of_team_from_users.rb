class RemoveLeaderOfTeamFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :leader_of_team
  end
end
