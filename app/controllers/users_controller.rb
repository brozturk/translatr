class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, success: 'Üyeliğiniz başarılı bir şekilde yapıldı.'
    else
      redirect_to new_user_path, error: 'Girmiş olduğunuz bilgilerde hata var.Lütfen tekrar deneyin.'
    end
  end

  def index

  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, 
                                 :password_confirmation)
  end
end
