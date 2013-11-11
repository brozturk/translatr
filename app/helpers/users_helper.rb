module UsersHelper

  def check_for_translation(text)
    if text.translation.blank?
      return 'Çevrilmedi'
    else
      return 'Çevrildi'
    end
  end

end
