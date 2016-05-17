class JobsController < ApplicationController
  include ApplicationHelper
  def index
    jobs = Job.all
    @jobs = jobs.paginate(:page => params[:page], :per_page => 6)
  end
end
