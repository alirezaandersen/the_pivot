module JobHelper
  def saved_favorites_condition(user, job_id)
    user && !user.users_jobs.where(job_id: job_id, status: 1).empty?
  end

  def remove_favorites_condition(user, job_id)
    user && !user.users_jobs.where(job_id: job_id).empty?
  end

end
