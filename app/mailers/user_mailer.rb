class UserMailer < ActionMailer::Base
  default from: "translatr@example.com"

  def password_reset(user)
    @user = user

    mail to: user.email, subject: 'Şifre Yenileme'
  end
end
