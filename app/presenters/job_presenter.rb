class JobPresenter
  attr_reader :job, :template

  def initialize(job, template)
    @job = job
    @template = template
  end

  def h
    template
  end

  def id
    job.id
  end

  def title
    job.title.capitalize
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
    job.education.capitalize
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

  def already_applied_for?(user)
    return true if job.users_jobs.find_by(user_id: user.id, status: 1)
  end
end
