class JobsController < ApplicationController
  include ApplicationHelper
  def index
    @jobs = Job.all
  end

  def show
    @jobs = Job.find_by(slug: params[:title])
  end
end
