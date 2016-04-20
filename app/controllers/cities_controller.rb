class CitiesController < ApplicationController

  def show
    @city = City.includes(:tasks).find_by(params[:slug])
  end

end
