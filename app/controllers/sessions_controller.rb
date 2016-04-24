class SessionsController < ApplicationController

  def new
  end

  def create
    @volunteer = Volunteer.find_by(username: params[:session][:username])
    if @volunteer && @volunteer.authenticate(params[:session][:password])
      session[:volunteer_id] = @volunteer.id
      flash[:notice] = "Logged in as #{@volunteer.username}"
      role_redirect
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

  private

  def role_redirect
    if @volunteer.admin?
      flash[:notice] = "You have been logged in as an admin"
      redirect_to admin_dashboard_path
    else
      cart_redirect
    end
  end

  def cart_redirect
    if session[:cart].nil?
      redirect_to dashboard_path
    else
      redirect_to cart_path
    end
  end

end
