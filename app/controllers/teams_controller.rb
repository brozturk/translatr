class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def show
    @team = current_resource
    @relationships = UserTeam.where(team_id: @team.id, state: 'accepted')
  end
  
  def create
    @team = Team.new(team_params)
    @team.leader_id = current_user.id
    if @team.save
      current_user.update_columns(leader: 'true', leader_of_team: @team.id)
      UserTeam.create(user_id: current_user.id, team_id: @team.id, state: 'accepted')
      redirect_to user_path(current_user), success: 'Grup kuruldu...Grup işlemleri sekmesinden grubunuzu yönetebilirsiniz.'
    else
      redirect_to new_team_path, danger: 'Grup oluştururken bir hata oluştu.Tekrara denemenizde fayda var.'
    end
  end
  
  private

  def team_params
    params.require(:team).permit(:name, :leader_id)
  end

  def current_resource
    @current_resource ||= Team.find(params[:id]) if params[:id] 
  end

end
