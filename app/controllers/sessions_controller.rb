class SessionsController < ApplicationController

  def new
  end

  def create
    @volunteer = Volunteer.find_by(username: params[:session][:username])
    if @volunteer && @volunteer.authenticate(params[:session][:password])
      session[:volunteer_id] = @volunteer.id
      flash[:notice] = "Logged in as #{@volunteer.username}"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Invalid. Please try again."
      render :new
    end
  end

  def destroy
    session.clear
    flash[:warning] = "Logged out!"
    redirect_to root_path
  end

end
