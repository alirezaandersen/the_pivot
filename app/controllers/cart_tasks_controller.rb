class CartTasksController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    task = Task.find(params[:task_id])
    if @cart.has_task?(task.id)
      flash[:notice] = "Task is already in your Cart!"
    else
      @cart.add_task(task.id)
      session[:cart] = @cart.contents
      flash[:notice] = "Task added!"
    end
    redirect_to request.referrer
  end

  def show
    @tasks = @cart.tasks
  end

  def destroy
    task = Task.find(params[:id])
    @cart.remove_task(task.id)
    flash[:notice] = "Successfully removed #{task.link} from your cart."
    redirect_to cart_path
  end
end
