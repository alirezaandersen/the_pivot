class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cart, :all_cities
  helper_method :current_volunteer

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_volunteer
    @current_volunteer ||= Volunteer.find(session[:volunteer_id]) if session[:volunteer_id]
  end

  def all_cities
    @cities = City.all
  end

end
