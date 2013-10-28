class ApplicationController < ActionController::Base
  before_filter :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UserTeamsHelper

  delegate :allow?, to: :current_permission
  helper_method :allow?
  
  add_flash_types :success, :danger 

  private

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    if !current_permission.allow?(params[:controller], params[:action], current_resource)
      redirect_to root_url, danger: 'Bunu yapmaya izniniz yok'
    end
  end
  
end
