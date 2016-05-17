class UsersJobsController < ApplicationController
  before_action :authorize_application_submission!, only: [:create]

  def create
    current_user
    @job = UsersJob.query_record(find_job.id, current_user)
    flash[:apply_success] = "You have applied for #{find_job.title} with #{find_job.company.name}."
    redirect_to dashboard_path
  end

  def show
    @jobs = Job.joins(:users_jobs).where(users_jobs: { user_id: current_user.id, status: 1 })
  end

  def authorize_application_submission!
    unless job_application.allow_to_apply?
      redirect_to company_job_path(find_job.company, find_job.title)
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
