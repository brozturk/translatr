class TextsController < ApplicationController

  def new
    @text = Text.new
    @team = Team.find(params[:team_id])
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
    @team = Team.find(params[:team_id])
    @texts = @team.texts
  end
  
  def show
    @text = Text.find(params[:id])
    @team = @text.team
    @translation = Translation.new
  end

  private

  def text_params
    params.require(:text).permit(:title, :text, :team_id)
  end

end
