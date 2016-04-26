class Admin::TasksController < Admin::BaseController
  def new
    @task = Task.new
  end
end
