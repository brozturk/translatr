class UserTeamsController < ApplicationController
  def new
  end

  def create
    @request = UserTeam.new(user_team_params)
    if @request.save
      redirect_to user_path(current_user), success: 'Gruba katılım isteği gönerildi'
    else
      redirect_to new_users_path, danger: 'Gruba davet başarısız oldu lütfen tekrar dene'
    end
  end

  private 

  def user_team_params
    params.require(:user_team).permit(:user_id, :team_id, :leader_of_team)
  end
end
