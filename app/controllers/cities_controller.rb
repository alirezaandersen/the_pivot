class CitiesController < ApplicationController

  def show
    @city = City.includes(:tasks).find_by(name: params[:name])
    # @city = City.includes(:tasks).find(params[:slug])
  end

end
