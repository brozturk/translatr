class SessionsController < ApplicationController
  before_filter :redirect_if_signed_in, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user_path(user), success: 'Başarılı bir şekilde giriş yapıldı!'
    else
      redirect_to root_path, danger: 'Giriş sırasında sorun oluştu lütfen bilgilerin doğruluğunu kontrol et' 
    end
  end

  def destroy
    sign_out
    redirect_to root_path, success: 'Başarılı bir şekilde çıkış yapıldı.' 
  end

  private

  def redirect_if_signed_in
    redirect_to user_path(current_user) if signed_in?
  end
end
