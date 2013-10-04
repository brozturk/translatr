class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email]) 
    if user && user.authenticate(params[:session][:password])
      redirect_to users_path(user), success: 'Başarılı bir şekilde giriş yapıldı!'
    else
      redirect_to root_path, danger: 'Giriş sırasında sorun oluştu lütfen bilgilerin doğruluğunu kontrol et' 
    end
  end

  def destroy
  end
end
