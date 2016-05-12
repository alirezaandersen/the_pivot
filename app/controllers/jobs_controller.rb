class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @favorites
    @job = Job.find_by(title: params[:title])
  end
end
