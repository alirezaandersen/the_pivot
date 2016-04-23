class VolunteerTasksController < ApplicationController

  def show
    @volunteer_tasks = current_volunteer.tasks
  end

  def create
    session[:cart].each do |k, v|
      Task.find(k).update_attributes(volunteer_id: current_volunteer.id)
    end
    flash[:notice] = "Order was successfully placed"
    session[:cart] = {}
    redirect_to commitments_path


    # checkout process
    # destroy cart session

    # redirect_to :show
  end
end
