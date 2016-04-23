class VolunteerTasksController < ApplicationController

  def show
    @volunteer_tasks = current_volunteer.tasks
  end

  def create
    VolunteerTasks.associate_tasks(session[:cart], current_volunteer)
    flash[:notice] = "Commitment was successfully placed"
    session[:cart] = {}
    redirect_to commitments_path
  end
end
