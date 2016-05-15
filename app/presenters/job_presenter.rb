class JobPresenter
  attr_reader :job, :template, :user

  def initialize(job, user, template)
    @job = job
    @user = user
    @template = template
  end

  def h
    template
  end

  def id
    job.id
  end

  def title
    job.title
  end

  def company
    job.company.name
  end

  def logo
    job.company.logo
  end

  def city
    job.city.name_and_state
  end

  def education
    job.education
  end

  def experience
    job.years_of_experience
  end

  def department
    job.department
  end

  def salary
    job.salary
  end

  def description
    job.description
  end

  def job_already_applied_for?
    # UsersJob.exists?(job_id: job.id)
    return true if job.users_jobs.find_by(user_id: user.id, status: 1)
  end

  def login
    h.link_to "LOGIN TO APPLY", login_path, class:"slider-btn waves-effect waves-light btn teal lighten-3"
  end

  def unfavorite
    h.link_to "UNFAVORITE", favorite_path(job.id), class:"slider-btn waves-effect waves-light btn teal lighten-3", method: :delete
  end

  def favorite
    h.link_to "FAVORITE", favorites_path, class:"slider-btn waves-effect waves-light btn teal lighten-3", method: :post
  end
end
