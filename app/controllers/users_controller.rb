class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      binding.pry
      flash[:notice] = "Account Created! Logged in as #{@user.first_name}"
      favorite_jobs(session[:favorites], current_user) unless session[:favorites].nil?
      redirect_to dashboard_path
    else
      flash.now[:error] = "Invalid. Please try again."
      render :new
    end
  end

  def show
    render file: '/public/404' if current_user.nil?
    @user = current_user
  end

  def edit
    render file: '/public/404'
  end

  private

  def user_params
    params.require(:user).permit(
                          :first_name,
                          :last_name,
                          :email,
                          :password,
                          :password_confirmation)
  end
end
