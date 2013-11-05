class TextsController < ApplicationController
  before_filter :check_for_team, only: [:index, :personal]

  def new
    @text = Text.new
    variables_for_team_nav
  end

  def create
    @team = Team.find(params[:team_id])
    @text = @team.texts.new(text_params)
    @text.user_id = current_user.id
    if @text.save
      redirect_to new_team_text_path(params[:team_id]),  success: 'Çeviri başarılı şekilde kaydedildi.'
    else
      redirect_to new_team_text_path(params[:team_id]), danger: 'Çeviri oluşturulması sırasında bir hata oluştu lütfen tekrar deneyin.' 
    end
  end

  def index
    variables_for_team_nav
  end
  
  def show
    @text = current_resource
    @team = @text.team
    @translation = Translation.new
  end

  def edit
    @text = current_resource
  end

  def destroy
    @text = current_resource
    @team = @text.team
    if @text.destroy
      redirect_to team_texts_path(@team), success: 'Yazınız ve varsa çevirisi silindi'
    end
  end
  
  def update
    @text = current_resource
    if @text.update(text_params)
      redirect_to text_path(@text), success: 'Çeviri başarılı bir şekilde editlendi'
    end
  end

  def personal
    variables_for_team_nav
  end

  private

  def text_params
    params.require(:text).permit(:title, :text, :team_id)
  end

  def current_resource
    @current_resource ||= Text.find(params[:id]) if params[:id]
  end

  def check_for_team
    @team = Team.find(params[:team_id])
    if !@team.in?(current_user.teams)
      redirect_to root_url, danger: 'Bunu yapmaya izniniz yok'
    end
  end

  def variables_for_team_nav
    @team = Team.find(params[:team_id])
    @relationship = UserTeam.where(team_id: @team.id, user_id: current_user.id, state: 'accepted').take
    @personal_texts = @team.texts.where(user_id: current_user.id).paginate(page: params[:page], per_page: 6)
    @untranslated = @team.texts.where{id.not_in Translation.select{text_id}.uniq}.paginate(page: params[:page], per_page: 6)
    @texts = @team.texts.paginate(page: params[:page], per_page: 6)
  end
end
