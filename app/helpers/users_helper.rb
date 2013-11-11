module UsersHelper

  def check_for_translation(text)
    if text.translation.blank?
      return 'Çevrilmedi'
    else
      return 'Çevrildi'
    end
  end
  
  def texts_without_translation
    @untranslated = []
    current_user.teams.each do |team|
      team.texts.where{id.not_in Translation.select{text_id}.uniq}.latest.each do|text|
        @untranslated << text
      end
    end
    return @untranslated
  end

end
