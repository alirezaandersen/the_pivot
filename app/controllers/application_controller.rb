class ApplicationController < ActionController::Base
  include ApplicationHelper
  include JobHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  utf8_enforcer_workaround

  add_flash_types :success, :info, :warning, :danger

  before_action :authorize!, :set_favorites, :all_cities
  helper_method :current_user, :favorite_jobs

  def set_favorites
    @favorites ||= Favorites.new(session[:favorites])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= PermissionsService.new(current_user, params[:controller], params[:action])
  end

  def authorize!
    unless current_permission.allow?
      redirect_to root_url, danger: "You are not allowed to pass."
    end
  end


  def all_cities
    @cities = City.all
  end
end
