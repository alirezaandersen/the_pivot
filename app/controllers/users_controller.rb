class UsersController < ApplicationController

  def index
    user = User.all
    @users = user.paginate(:page => params[:page], :per_page => 20)
  end

  def admin_index
    @company_name = Company.find(params[:company_id]).name
    @users = User.where(company_id: params[:company_id])
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
      (current_user.store_admin? && (current_user.company_id == admin_params[:company_id].to_i)) || current_user.platform_admin?
      @user = User.create(admin_params)
      @user.roles << Role.find_by(name: "store_admin")
      role_redirect
    else
      @user = User.new(user_params)
      if @user.save
         @user.roles << Role.find_by(name: "registered_user")
        session[:user_id] = @user.id
        flash[:notice] = "Account Created! Logged in as #{@user.first_name}"
        if !session[:favorites].nil?
          favorite_jobs_from_session(session[:favorites], current_user)
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
    render file: '/public/404' if current_user.nil?
    render 'users/platform_admin' if current_user.platform_admin?
    render 'users/store_admin' if current_user.store_admin?
    #will default to show.html.erb (if guest)
  end

  def edit
    render file: '/public/404'
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
