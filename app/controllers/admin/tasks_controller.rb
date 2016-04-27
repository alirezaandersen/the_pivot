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
      byebug
      flash[:notice] = "Invalid! Try Again"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    if @task.update(task_params)
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
                                 :hours, :city_id, :address, :image)
  end

  def image_params
    params.require(:image)
  end
end
