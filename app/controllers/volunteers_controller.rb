class VolunteersController < ApplicationController
  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.save
      #user session
      flash[:notice] = 
      redirect_to dashboard_path(@volunteer)
    else
      render :new
    end
  end


  private

  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :username,
                                      :email, :password, :password_confirmation)
  end
end
