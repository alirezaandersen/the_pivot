class JobApplicationService
  extend Forwardable

  def_delegators :favorited?,
                 :applied?,
                 :apply_to_job

  def initialize(params, user)
    @_user = user
    @_job = params[:job]
    @_application = { job: job,
                      resume: params[:resume],
                      cover_letter: params[:cover_letter] }
  end

  def allow_to_apply?
    case
    when user_job && user_job.favorited?
      binding.pry
      update_with_application
      return true
    when user_job && user_job.applied?
      return false
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

    def user_job
      @_user_job = UsersJob.query_record(job, user)
    end
end
