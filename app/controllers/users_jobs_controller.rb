class CommitmentsController < ApplicationController

  def show
    if current_user.nil?
      render file: '/public/404'
    else
      @upcoming_tasks  = current_user.tasks.pledged
      @pending_tasks   = current_user.tasks.pending
      @completed_tasks = current_user.tasks.completed
    end
  end

  def create
    Commitment.associate_tasks(session[:cart], current_user)
    flash[:notice] = "You're Committed!"
    session[:cart] = {}
    redirect_to commitments_path
  end
end
