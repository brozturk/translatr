class TranslationsController < ApplicationController

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

  def index

  end

  private
  
  def translation_params
    params.require(:translation).permit(:team_id, :text_id, :translation_text)
  end
end
