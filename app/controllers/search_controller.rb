class SearchController < ApplicationController
  def show
    @jobs = Job.all
    if params[:search] != "Enter a job title"
      @jobs = Job.search(params[:search]).order("created_at DESC")
    else
      flash[:null_search] = "Enter a job title to search."
      redirect_to root_path
    end
  end
end
