class CartTasksController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    task = Task.find(params[:task_id])
    @cart.add_task(task.id)
    session[:cart]= @cart.contents
    flash[:notice] = "Task added!"
    redirect_to tasks_path
  end

  def show
    @tasks = @cart.contents.map { |task_id, _quantity| Task.find(task_id) }
  end
end
