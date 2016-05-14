class UsersJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  enum status: %w(favorited applied)

  def self.query_record(job, user)
    find_by(job_id: job.to_i, user_id: user.id)
  end

  def self.query_for_user_applied_jobs(user)
    where(user_id: user.id, status: 1).select(:job_id).map { |user_job| user_job.job }
  end

  def self.apply_to_job(params, user)
    create(user_id: user.id, job_id: params[:job].to_i, resume: params[:resume], cover_letter: params[:cover_letter], status: 1)
  end

  def update_with_application(params, user)
    user_job = UsersJob.query_record(params[:job], user)

    user_job.update(resume: params[:resume], cover_letter: params[:cover_letter])
    user_job.applied!
    user_job
  end
end
