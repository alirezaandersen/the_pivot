class CitiesController < ApplicationController

  def show
    @city = City.includes(:tasks).find_by(slug: params[:name].parameterize)
  end

end
