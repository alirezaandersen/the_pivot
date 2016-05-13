class UsersJobsController < ApplicationController
  def create
    UserJob.apply_jobs(params, user)
    redirect_to dashboard_path
  end
end
