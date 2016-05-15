class SavedFavoritesController < ApplicationController
  def create
    # if !current_user.users_jobs.where(job_id: params[:job_id]).empty? && session[:favorites].nil?
    #   redirect_to my_favorites_path
    if current_user && session[:favorites].nil? || session[:favorites] == {}
      UsersJob.favorite_jobs(params[:job_id], current_user)
      flash[:notice] = "Your Favorites are saved!"

    # elsif current_user.users_jobs.exists?(job_id: session[:favorites].keys, status: 0)
    #   session[:favorites] = {}
    #   redirect_to my_favorites_path
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
      # @favorited_jobs = current_user.users_jobs.favorited
    end
  end
end
