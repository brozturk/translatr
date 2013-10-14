class TeamsController < ApplicationController
  def new
    @team = Team.new
  end
  
  def create
    @team = Team.new(team_params)
    @team.leader_id = current_user.id
    if @team.save
      current_user.update_columns(leader: 'true', leader_of_team: @team.id)
      redirect_to user_path(current_user), success: 'Basarili'
    else
      redirect_to new_user_teams_path, danger: 'birdaha dene'
    end
  end
  
  private

  def team_params
    params.require(:team).permit(:name, :leader_id)
  end
end
