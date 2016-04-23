class VolunteerTasksController < ApplicationController

  def show
    @volunteer_tasks = current_volunteer.tasks
  end

  def create

                                  
    # checkout process
    # destroy cart session

    # redirect_to :show
  end
end
