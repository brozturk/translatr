class UsersController < ApplicationController
  before_filter :redirect_if_signed_in, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.set_as_translator if params[:set_translator]
    if @user.save
      sign_in @user
      redirect_to user_path(@user), success: 'Üyeliğiniz başarılı bir şekilde yapıldı.'
    else
      redirect_to new_user_path, danger: 'Girmiş olduğunuz bilgilerde hata var.Lütfen tekrar deneyin.'
    end
  end

  def index
    @users = User.that_is_not_a_translator
    @translators = User.that_is_a_translator
    @user_teams = UserTeam.new
    @team = Team.find(params[:team_id])
  end

  def show
    @texts = current_user.texts.latest
  end

  def edit
    @user = current_resource
  end

  def update
    @user = current_resource
    if @user.update(user_params)
      redirect_to root_url, success: 'Şifre başarılı bir şekilde değiştirildi'
    else
      redirect_to root_url, danger: 'Şifre değiştirilirken bir hata oluştu lütfen tekrar deneyin'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, 
                                 :password_confirmation, :translator)
  end

  def current_resource
    @current_resource ||= User.find(params[:id])
  end

  def redirect_if_signed_in
    redirect_to user_path(current_user) if signed_in?
  end
end
