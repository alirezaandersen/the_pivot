class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.email}"
      role_redirect
    else
      flash.now[:error] = "Invalid. Please try again."
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Logged out!"
    redirect_to root_path
  end

  private

  def role_redirect
    if @user.admin?
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
