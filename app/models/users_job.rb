class UsersJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  enum status %w(favorited, applied)

  def self.apply_jobs(job, user)
    job = Job.find(id)
    user_job = user.jobs.create(job_id: job.id)
    user.user_jobs.applied!
    user_job.applied!
    # think about other conditions
  end
end
