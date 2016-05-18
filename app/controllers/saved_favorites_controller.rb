class SavedFavoritesController < ApplicationController
  def create
    UsersJob.favorite_jobs(params[:job_id], current_user)
    flash[:notice] = "Your Favorites are saved!"
    redirect_to request.referrer
  end

  def index
    if current_user.nil?
      render file: '/public/404'
    else
      @jobs = UsersJob.current_users_favorited_jobs(current_user)
    end
  end

  def destroy
    UsersJob.remove_saved_favorite(current_user, params[:id])
    # job = current_user.users_jobs.find_by(job_id: params[:id])
    # job.destroy
    redirect_to my_favorites_path
  end
end
