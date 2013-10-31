class UserTeamsController < ApplicationController

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

  def destroy
    @relationship = current_resource
    if @relationship.destroy
      redirect_to team_path(@relationship.team), success: "#{@relationship.user.name} Gruptan Atıldı"
    else
      redirect_to team_path(@relationship.team), danger: 'Bir Hata Oluştu Lütfen Tekrar Deneyin'
    end
  end

  private 

  def user_team_params
    params.require(:user_team).permit(:user_id, :team_id, :leader_of_team)
  end

  def current_resource
    @current_resource ||= UserTeam.find(params[:id]) if params[:id]
  end
end
