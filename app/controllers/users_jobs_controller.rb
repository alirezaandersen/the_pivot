class UsersJobsController < ApplicationController

  def create
    authorize_application_submission!
    current_user
    @job = UsersJob.query_record(find_job.id, current_user)
    flash[:apply_success] = "You have applied for #{find_job.title} with #{find_job.company.name}."
    redirect_to dashboard_path
  end

  def show
    @jobs = UsersJob.current_users_jobs(current_user, 1)
  end

  def authorize_application_submission!
    unless job_application.allow_to_apply?
      redirect_to company_job_path(find_job.company, find_job.title)
    end
  end

  private

    def users_jobs_params
      params.require(:users_jobs).permit(:resume_pdf,
                                         :cover_letter,
                                         :job)
    end

    def find_job
      id = params[:users_jobs][:job].to_i
      Job.find(id)
    end

    def job_application
      JobApplicationService.new(users_jobs_params, current_user)
    end
end
