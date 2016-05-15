class MultiPresenter
  attr_reader :job, :favorites, :template

  def initialize(objects, template)
    @job = JobPresenter.new( objects[:job],
                             objects[:user],
                             self )
    @favorites = FavoritePresenter.new( objects[:favorites],
                                        objects[:job],
                                        self )
  end

  def h
    template
  end
end
