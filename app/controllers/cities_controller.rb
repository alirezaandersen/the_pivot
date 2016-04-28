class CitiesController < ApplicationController

  def show
    @city = City.includes(:tasks).find_by(slug: params[:name].parameterize)
    flash[:notice] = "Tasks are coming soon to this city. The world is still your oyster." if @city.tasks.empty?
  end

end
