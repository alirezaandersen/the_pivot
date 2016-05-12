class HomeController < ApplicationController

  def index
    @cities = City.all
  end

  def about_us

  end

end
