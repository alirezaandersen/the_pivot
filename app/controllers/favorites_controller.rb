class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    job = Job.find(params[:job_id])
    if @favorites.has_job?(job.id)
      flash.now[:notice] = "Job is already in your Favorites!"
    else
      @favorites.add_job(job.id)
      session[:favorites] = @favorites.contents
      flash[:notice] = "Job favorited!"
    end
    redirect_to request.referrer
  end

  def show
    @jobs = @favorites.jobs

  end

  def destroy
    job = Job.find(params[:id])
    @favorites.remove_job(job.id)
    redirect_to job_path(job)
  end
end
