class CartTasksController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    task = Task.find(params[:task_id])
    if @cart.has_task?(task.id)
      flash[:notice] = "Task is already in your Cart!"
    else
      @cart.add_task(task.id)
      session[:cart]= @cart.contents
      flash[:notice] = "Task added!"
    end
    redirect_to tasks_path
  end

  def show
    @tasks = @cart.contents.map { |task_id, _quantity| Task.find(task_id) }
  end

  def destroy
    task = Task.find(params[:id])
    @cart.remove_task(task.id)
    session[:cart]= @cart.contents
    flash[:notice] = "Task removed!"
    redirect_to '/cart'
  end
end
