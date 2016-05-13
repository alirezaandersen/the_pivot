class UsersJobsController < ApplicationController

  def create
    if UsersJob.exists?(job_id: session[:favorites].keys )
      redirect_to users_job_path(current_user)
    else
      favorite_jobs(session[:favorites], current_user)
      flash[:notice] = "Your Favorites are saved!"
      session[:favorites] = {}
      redirect_to users_job_path(current_user)
    end
  end

  def show
    if current_user.nil?
      render file: '/public/404'
    else
      @favorited_jobs = current_user.users_jobs.where(status: 0)
    end
  end

end
