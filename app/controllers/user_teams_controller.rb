class UserTeamsController < ApplicationController

  def create
    @request = UserTeam.new(user_team_params)
    if @request.save
      redirect_to team_users_path(@request.team), success: 'Gruba katılım isteği gönerildi'
    else
      redirect_to team_users_path(@request.team), danger: 'Gruba davet başarısız oldu lütfen tekrar dene'
    end
  end

  def index
    @user_teams = UserTeam.new
    @requests = UserTeam.where(user_id: current_user.id, state: 'requested').paginate(
                                      page: params[:page], per_page: 8)
  end

  def edit
    @relationship = current_resource
    @team = @relationship.team
  end

  def update
    @request = current_resource
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
    params.require(:user_team).permit(:user_id, :team_id, :state)
  end

  def current_resource
    @current_resource ||= UserTeam.find(params[:id]) if params[:id]
  end
end
