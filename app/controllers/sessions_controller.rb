class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
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
    if @user.platform_admin?
      flash[:notice] = "Welcome Super #{@user.first_name}"
      redirect_to platform_admin_dashboard_path
    elsif @user.store_admin?
      flash[:notice] = "Welcome #{@user.first_name}"
      redirect_to store_admin_dashboard_path
    else
      flash[:notice] = "Account Created! Logged in as #{@user.first_name}"
      redirect_to dashboard_path
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
