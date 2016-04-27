class Admin::TasksController < Admin::BaseController
  before_action :set_task, only: [:edit, :update]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task Created!"
      redirect_to @task
    else
      flash[:notice] = "Invalid! Try Again"
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      flash[:notice] = "Task Updated!"
      redirect_to task_path(@task.id)
    else
      flash[:notice] = "Invalid! Try Again"
      render :edit
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :date, :start_time,
                                 :hours, :city_id, :address, :zip_code, :image)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
