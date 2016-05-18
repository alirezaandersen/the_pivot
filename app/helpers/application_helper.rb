module ApplicationHelper

  def present(model, klass=nil)
    klass ||= "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
    presenter
  end

end
