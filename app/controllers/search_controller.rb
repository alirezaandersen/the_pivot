class SearchController < ApplicationController
  def show
    @jobs = Job.all
    if params[:search]
      @jobs = Job.search(params[:search]).order("created_at DESC")
    else
      flash[:null_search] = "Looks like there are no jobs fitting your search."
      redirect_to jobs_path
    end
  end
end
