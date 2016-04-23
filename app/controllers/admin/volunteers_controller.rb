class Admin::VolunteersController < Admin::BaseController

  def show
    @admin = current_volunteer
  end


  def edit
    @admin = current_volunteer
  end

  def update
    @admin = current_volunteer
    if @admin.update(volunteer_params)
      flash[:notice] = "Your Account Has Been Updated"
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :username,
                                      :email, :password, :password_confirmation)
  end

end
