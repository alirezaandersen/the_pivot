class Admin::UsersController < Admin::BaseController

  def show
    @admin = current_user
  end


  def edit
    @admin = current_user
  end

  def update
    @admin = current_user
    if @admin.update(users_params)
      flash[:notice] = "Your Account Has Been Updated"
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  private

  def users_params
    params.require(:volunteer).permit(
                               :first_name,
                               :last_name,
                               :email,
                               :password,
                               :password_confirmation)
  end

end
