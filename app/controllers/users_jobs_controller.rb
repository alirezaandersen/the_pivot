class UsersJobsController < ApplicationController
  before_action :authorize_application_submission!, only: [:create]

  def create
    current_user
    @job = UsersJob.query_record(find_job.id, current_user)
    flash[:apply_success] = "You have applied for #{find_job.title} with #{find_job.company.name}."
    redirect_to dashboard_path
    # if already applied, on click trigger alert that says this job has already been applied for, rather than submission form; do not want to implement another button until view has been cleaned up and tests created
  end

  def show
    @jobs = current_user.jobs
  end

  def authorize_application_submission!
    unless job_application.allow_to_apply?
      redirect_to job_path(find_job.title)
    end
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

    def job_application
      JobApplicationService.new(users_jobs_params, current_user)
    end
end
