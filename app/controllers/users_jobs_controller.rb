class UsersJobsController < ApplicationController
  def create
    user = current_user
    UsersJob.apply_to_job(users_jobs_params, user)
    flash[:apply_success] = "You have applied for #{find_job.title} with #{find_job.company.name}."
    redirect_to dashboard_path
  end

  private

  def users_jobs_params
    params.require(:users_jobs).permit(:resume,
                                       :cover_letter,
                                       :job)
  end

  def find_job
    id = params[:users_jobs][:job].to_i
    Job.find(id)
  end
end
