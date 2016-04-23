class VolunteerTasksController < ApplicationController
  def show
    @volunteer_tasks = current_volunteer.tasks
  end

  def create
    redirect_to :show
  end
end
