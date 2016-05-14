class UsersJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  enum status: %w(default favorited applied)

  def self.apply_to_job(params, user)
    job_id = params[:job].to_i
    user_job = UsersJob.find_by(job_id: job_id)

    if user_job && !user_job.applied?
      user_job.update(resume: params[:resume], cover_letter: params[:cover_letter])
      user_job.applied!
    else
      UsersJob.create(user_id: user.id, job_id: job_id, resume: params[:resume], cover_letter: params[:cover_letter], status: 2)
    end
  end
end
