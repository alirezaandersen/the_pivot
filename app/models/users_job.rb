class UsersJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  enum status: %w(favorited applied)

  # def self.favorite_jobs(favorites, current_user)
  #   favorites.each do |job_id, _v|
  #     job = Job.find(job_id)
  #     users_job = UsersJob.create(user_id: current_user.id, job_id: job.id)
  #     users_job.favorited!
  #   end
  # end

  def self.favorited
    where(status: 0)
  end

  def self.applied
    where(status: 1)
  end
end
