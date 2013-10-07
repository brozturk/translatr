class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to user_path(@user), success: 'Üyeliğiniz başarılı bir şekilde yapıldı.'
    else
      redirect_to new_user_path, danger: 'Girmiş olduğunuz bilgilerde hata var.Lütfen tekrar deneyin.'
    end
  end

  def index
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, 
                                 :password_confirmation)
  end
end
