class VolunteersController < ApplicationController

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.save
      session[:volunteer_id] = @volunteer.id
      flash[:notice] = "Account Created!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Invalid. Please try again."
      render :new
    end
  end

  def show
    @volunteer = current_volunteer
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :username,
                                      :email, :password, :password_confirmation)
  end
end
