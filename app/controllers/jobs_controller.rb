class JobsController < ApplicationController
  include ApplicationHelper
  def index
    @jobs = Job.all
  end

  # def show
  #   @job = Job.find_by(slug: params[:title])
  # end
end
