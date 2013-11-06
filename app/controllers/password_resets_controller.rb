class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset_info
    redirect_to root_path, success: 'Şifrenizi yenilemeniz için göderdiğimiz maildeki linke tıklamanız gerekiyor' 
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 4.hours.ago
      redirect_to new_password_reset_path, danger: 'Gönderilen lşinkin süresi dolmuştur lütfen tekrar deneyin.in'
    elsif @user.update(user_params)
      redirect_to root_url, success: 'Şifreniz değiştirilmiştir.Yeni şifreyle giriş yapabilirsiniz.'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
