class MemberMailer < ActionMailer::Base
  default from: "translatr@example.com"

  def text_creation_notification(text)
    @text = text
    @users = @text.team.users

    @mails = []
    @users.each do |user|
      @mails << (user.email)
    end
    
    mail :to =>@mails, :subject => "Yeni Metin Oluşturuldu"
  end

  def text_update_notification(text)
    @text = text
    @users = @text.team.users

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
  
  def translation_update_notification(translation)
    @translation = translation
    
    @mails = []
    @translation.team.users.each do |user|
      @mails << (user.email)
    end
    
    mail :to =>@mails, :subject => "Çeviri Değişikliği Yaplıdı"
  end

  def group_invitation_notification(request)
    @request = request
    @user = @request.user

    mail :to =>@user.email, :subject => "Davet!"
  end
end

