class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @objects = { job: Job.find_by(slug: params[:title]),
                 favorites: @favorites, user: current_user }
  end
end
