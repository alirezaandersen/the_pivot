module ApplicationHelper

  def favorite_jobs(favorites, current_user)
    favorites.map do |job_id, _v|
      job = Job.find(job_id)
      users_job = UsersJob.create(user_id: current_user.id, job_id: job.id)
      users_job.favorited!
      users_job
    end
  end

  def present(objects)
    presenter = MultiPresenter.new(objects, self)
    yield presenter if block_given?
    presenter
  end
end
