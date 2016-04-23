class VolunteerTasksController < ApplicationController

  def show
    @volunteer_tasks = current_volunteer.tasks
  end
end
