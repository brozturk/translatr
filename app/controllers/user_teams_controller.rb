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

  def index
    @user_teams = UserTeam.new
  end

  def update
    @request = UserTeam.find(params[:id])
    if params[:commit] == 'Kabul Et'
      @request.accept
      redirect_to user_path(current_user), success: 'Gruba katılma isteğini kabul ettiniz.'
    elsif params[:commit] == 'Reddet'
      @request.deny
      redirect_to user_teams_path, danger: 'Gruba katılma isteğini reddettiniz.'
    end
  end

  private 

  def user_team_params
    params.require(:user_team).permit(:user_id, :team_id, :leader_of_team)
  end
end
