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
    @text = current_resource
    @team = @text.team
    @translation = Translation.new
  end

  def destroy
    @text = current_resource
    @team = @text.team
    if @text.destroy
      redirect_to team_texts_path(@team), success: 'Yazınız ve varsa çevirisi silindi'
    end
  end

  private

  def text_params
    params.require(:text).permit(:title, :text, :team_id)
  end

  def current_resource
    @current_resource ||= Text.find(params[:id]) if params[:id]
  end

end
