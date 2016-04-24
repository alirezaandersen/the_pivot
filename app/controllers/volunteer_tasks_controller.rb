class VolunteerTasksController < ApplicationController

  def show
    if current_volunteer.nil?
      render file: '/public/404'
    else
      @upcoming_tasks  = current_volunteer.tasks.where(status: 2)
      @pending_tasks   = current_volunteer.tasks.where(status: 3)
      @completed_tasks = current_volunteer.tasks.where(status: 5)
    end
  end

  def create
    VolunteerTasks.associate_tasks(session[:cart], current_volunteer)
    flash[:notice] = "Commitment was successfully placed"
    session[:cart] = {}
    redirect_to commitments_path
  end
end
