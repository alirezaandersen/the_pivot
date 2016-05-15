class JobsController < ApplicationController
  def index
    jobs = Job.all
    @jobs = jobs.paginate(:page => params[:page], :per_page => 6)
  end

  def show
    @favorites
    @job = Job.find_by(title: params[:title])
  end
end
