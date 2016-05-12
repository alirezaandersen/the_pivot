class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_favorites, :all_cities
  helper_method :current_user

  def set_favorites
    @favorites ||= Favorites.new(session[:favorites])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def all_cities
    @cities = City.all
  end

end
