class TextsController < ApplicationController

  def new
    @text = Text.new
  end

  def create
    @text = Text.create(text_params)
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

  private

  def text_params
    params.require(:text).permit(:title, :text)
  end

end
