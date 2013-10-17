class TextsController < ApplicationController

  def new
    @text = Text.new
  end

  def create
    @text = Text.create(text_params)
    if @text.save
      redirect_to new_text_path,  success: 'Çeviri başarılı şekilde kaydedildi.'
    else
      redirect_to new_text_path, danger: 'Çeviri oluşturulması sırasında bir hata oluştu lütfen tekrar deneyin.' 
    end
  end

  private

  def text_params
    params.require(:text).permit(:title, :text)
  end

end
