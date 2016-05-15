module ApplicationHelper

  def favorite_jobs(favorites, current_user)
    favorites.map do |job_id, _v|
      job = Job.find(job_id)
      users_job = UsersJob.create(user_id: current_user.id, job_id: job.id)
      users_job.favorited!
      users_job
    end
  end

  # def is_job_favorited?(job_id)
  #   return true if current_user.

    #return true if current_user has this job in favorites
    # or if current_user has this job saved (current_user.user_jobs.

end
