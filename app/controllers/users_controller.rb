class UsersController < ApplicationController

  def index
    user = User.all
    @users = user.paginate(:page => params[:page], :per_page => 20)
  end

  def admin_index
    @company_name = Company.find(params[:company_id]).name
    admins = User.company_users(params[:company_id])
    @users = admins.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    if current_user.nil?
      @user = User.new
      @title = "Create Account"
    else
      @company_id = params[:company_id] if current_user.platform_admin?
      @company_id = current_user.company_id if current_user.store_admin?
      flash[:error] = "Admin is missing a company id" if @company_id.nil?
      @user = User.new
    end
  end

  def create
    if !current_user.nil?
      @user = User.create(admin_params)
      @user.add_store_admin_role
      role_redirect
    else
      @user = User.new(user_params)
      if @user.save
        @user.add_registered_user_role
        session[:user_id] = @user.id
        flash[:notice] = "Account Created! Logged in as #{@user.first_name}"
        if !session[:favorites].nil?
          UsersJob.favorite_jobs_from_session(session[:favorites], current_user)
          session[:favorites] = {}
        end
        role_redirect
      else
        flash.now[:error] = "Invalid. Please try again."
        render :new
      end
    end
  end

  def show
    @user = current_user
   if current_user.nil?
     render file: '/public/404'
   elsif current_user.platform_admin?
       render 'users/platform_admin'
   elsif  current_user.store_admin?
     render 'users/store_admin'
   end
  end

  def resume
    @resumes = UsersJob.where(user_id: current_user.id, status: 1)
  end

  def resume
    @resumes =  UsersJob.where(user_id: current_user.id, status: 1)

  end

  def edit
    render file: '/public/404'
  end

  private

  def role_redirect
    if @user.platform_admin?
      flash[:notice] = "Welcome Super Admin, #{@user.first_name}"
      redirect_to platform_admin_dashboard_path
    elsif @user.store_admin?
      flash[:notice] = "Sucessfully created new store admin #{@user.first_name}!"
      redirect_to store_admin_dashboard_path
    else
      flash[:notice] = "Account Created! Logged in as #{@user.first_name}"
      redirect_to dashboard_path
    end
  end

  def user_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password,
    :password_confirmation)
  end

  def admin_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password,
    :password_confirmation,
    :company_id)
  end
end
