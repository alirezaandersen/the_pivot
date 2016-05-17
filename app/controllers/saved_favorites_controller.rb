class SavedFavoritesController < ApplicationController
  def create
    if current_user && session[:favorites].nil? || session[:favorites] == {}
      UsersJob.favorite_jobs(params[:job_id], current_user)
      flash[:notice] = "Your Favorites are saved!"
    else
      favorite_jobs_from_session(session[:favorites], current_user)
      flash[:notice] = "Your Favorites are saved!"
      session[:favorites] = {}
    end
    redirect_to my_favorites_path
  end

  def index
    if current_user.nil?
      render file: '/public/404'
    else
      @jobs = Job.joins(:users_jobs).where(users_jobs: { user_id: current_user, status: 0 })
    end
  end
end
