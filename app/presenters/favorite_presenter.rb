class FavoritePresenter
  attr_reader :favorites, :job, :template

  def initialize(favorites, job, template)
    @favorites = favorites
    @job = job
    @template = template
  end

  def h
    template
  end

  def check_for_job
    favorites.has_job?(job.id)
  end

end
