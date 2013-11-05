class TranslationsController < ApplicationController
  before_filter :check_for_team, only: [:index]

  def index
    variables_for_team_nav
  end

  def create
    team = Team.find(params[:team_id])
    @translation = team.translations.new(translation_params)
    @translation.user_id = current_user.id
    if @translation.save
      redirect_to text_path(@translation.text), success: 'Çeviri tamalandı'
    else
      redirect_to text_path(@translation.text), danger: 'Çeviri sırasında sorun oluştu lütfen tekrar dene'
    end
  end

  def edit
    @translation = current_resource
    @text = @translation.text
  end

  def destroy
    @translation = current_resource
    if @translation.destroy
      redirect_to text_path(@translation.text), success: 'Çeviri başarıyle silindi'
    end
  end

  def update
    @translation = current_resource
    if @translation.update(translation_params)
      redirect_to text_path(@translation.text), success: 'Çeviri başarıyla düzenlendi'
    end
  end

  private
  
  def translation_params
    params.require(:translation).permit(:team_id, :text_id, :translation_text)
  end

  def current_resource
    @current_resource ||= Translation.find(params[:id]) if params[:id]
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
