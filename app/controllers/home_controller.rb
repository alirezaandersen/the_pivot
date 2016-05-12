class HomeController < ApplicationController
  def index
    @job = Job.new
  end

end
