class CommitmentsController < ApplicationController

  def show
    if current_volunteer.nil?
      render file: '/public/404'
    else
      @upcoming_tasks  = current_volunteer.tasks.pledged
      @pending_tasks   = current_volunteer.tasks.pending
      @completed_tasks = current_volunteer.tasks.completed
    end
  end

  def create
    Commitment.associate_tasks(session[:cart], current_volunteer)
    flash[:notice] = "You're Committed!"
    session[:cart] = {}
    redirect_to commitments_path
  end
end
