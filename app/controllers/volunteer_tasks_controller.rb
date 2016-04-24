class VolunteerTasksController < ApplicationController

  def show
    if current_volunteer.nil?
      render file: '/public/404'
    else
      @volunteer_tasks = current_volunteer.tasks
    end
  end

  def create
    VolunteerTasks.associate_tasks(session[:cart], current_volunteer)
    flash[:notice] = "Order was successfully placed"
    session[:cart] = {}

    redirect_to commitments_path
  end
end
