class JobApplicationService
  extend Forwardable

  def_delegators :favorited?,
                 :applied?,
                 :apply_to_job

  def initialize(params, user)
    @_user = user
    @_job = params[:job]
    @_application = { job: job,
                      resume_pdf: params[:resume_pdf],
                      cover_letter: params[:cover_letter] }
  end

  def allow_to_apply?
    if already_applied_for_job_at_specific_company
      return false
    elsif favorited_job_at_specific_company
      update_with_application
      return true
    else
      submit_application
      return true
    end
  end

  def update_with_application
    user_job.update_with_application(application, user)
  end

  def submit_application
    UsersJob.apply_to_job(application, user)
  end

  private

    def job
      @_job
    end

    def user
      @_user
    end

    def application
      @_application
    end

    def company
      user_job.job.company
    end

    def user_job
      @_user_job = UsersJob.query_record(job, user)
    end

    def favorited_job_at_specific_company
      user_job && user_job.favorited? && (company == user_job.job.company)
    end

    def already_applied_for_job_at_specific_company
      user_job && user_job.applied? && (company == user_job.job.company)
    end
end
