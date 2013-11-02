class MemberMailer < ActionMailer::Base
  default from: "from@example.com"

  def text_creation_notification(users, text, text_creator)
    @users = users
    @text = text
    @text_creator = text_creator
    @mails = []
    @users.each do |user|
      @mails << (user.email)
    end
    
    mail :to =>@mails, :subject => "Yeni Metin Oluşturuldu"
  end

  def text_update_notification(users, text, person_who_updated)
    @users = users
    @text = text
    @person_who_updated = person_who_updated
    @mails = []
    @users.each do |user|
      @mails << (user.email)
    end
    
    mail :to =>@mails, :subject => "Metin Değişikliği Yapıldı"
  end

  def translation_creation_notification(translation)
    @translation = translation
    
    @mails = []
    @translation.team.users.each do |user|
      @mails << (user.email)
    end
    
    mail :to =>@mails, :subject => "Yeni Çeviri"
  end
end
