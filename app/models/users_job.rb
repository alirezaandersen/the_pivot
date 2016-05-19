class UsersJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  has_attached_file :resume_pdf

  validates_attachment_content_type :resume_pdf, :content_type => /\Aimage\/.*\Z/

  enum status: %w(favorited applied)

  def self.query_record(job, user)
    find_by(job_id: job.to_i, user_id: user.id)
  end

  def self.query_for_user_applied_jobs(user)
    where(user_id: user.id, status: 1).select(:job_id).map { |user_job| user_job.job }
  end

  def self.apply_to_job(params, user)
    # binding.pry
    create(user_id: user.id, job_id: params[:job].to_i, resume_pdf: params[:resume_pdf], cover_letter: params[:cover_letter], status: 1)
  end

  def update_with_application(params, user)
    user_job = UsersJob.query_record(params[:job], user)

    user_job.update(resume: params[:resume], cover_letter: params[:cover_letter])
    user_job.applied!
    user_job
  end

  def self.favorited
    where(status: 0)
  end

  def self.applied
    where(status: 1)
  end

  def self.favorite_jobs(job_id, user)
    users_job = UsersJob.create(user_id: user.id, job_id: job_id)
    users_job.favorited!
    users_job
  end

  def self.favorite_jobs_from_session(session, user)
    session.map do |job_id, _v|
      job = Job.find(job_id)
      users_job = UsersJob.create(user_id: user.id, job_id: job.id)
      users_job.favorited!
      users_job
    end
  end

  def self.current_users_jobs(user, status)
    Job.joins(:users_jobs).where(users_jobs: { user_id: user.id, status: status })
  end

  def self.remove_saved_favorite(user, job_id)
    users_job = user.users_jobs.find_by(job_id: job_id)
    users_job.destroy
  end
end
