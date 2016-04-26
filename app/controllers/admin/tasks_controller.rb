class Admin::TasksController < Admin::BaseController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task Created!"
      redirect_to city_path(@task.city)
    else
      flash[:notice] = "Invalid, Try Again"
      render :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :date, :start_time,
                                 :hours, :city_id, :image_path)
  end
end
