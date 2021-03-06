module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    if params[:remember_me]
      cookies.permanent[:remember_token] = remember_token
    else 
      cookies[:remember_token] = remember_token
    end
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||=  User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil 
    cookies.delete(:remember_token) 
  end

  def translator?
    current_user.translator
  end
end

