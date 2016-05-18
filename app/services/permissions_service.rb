class PermissionsService

  extend Forwardable

  def_delegators :user, :platform_admin?,
                         :store_admin?,
                         :registered_user?

  def initialize(user, controller, action)
    @_user = user || User.new
    @_controller = controller
    @_action = action
  end

  def allow?
    case
    when platform_admin?  then platform_admin_permissions
    when store_admin?     then store_admin_permissions
    when registered_user? then registered_user_permissions
    else
      guest_permissions
    end
  end

  private

  def platform_admin_permissions
    return true if everybody_permissions
    return true if user_jobs_controller_permissions
    return true if submissions_controller_platform_admin_permissions
    return true if contact_us_controller_platform_admin_permissions
    return true if companies_controller_platform_admin_permissions
    return true if users_controller_platform_admin_permissions
    return true if jobs_controller_admins_permissions
  end

  def store_admin_permissions
    return true if everybody_permissions
    return true if user_jobs_controller_permissions
    return true if saved_favorites_controller_permissions
    return true if users_controller_store_admin_permissions
    return true if companies_controller_store_admin_permissions
    return true if jobs_controller_admins_permissions
  end

  def registered_user_permissions
    return true if everybody_permissions
    return true if user_jobs_controller_permissions
    return true if saved_favorites_controller_permissions
    return true if submissions_controller_user__permissions
    return true if users_controller_users_permissions
    return true if companies_controller_users_permissions
    return true if jobs_controller_users_permissions
  end

  def guest_permissions
    return true if everybody_permissions
    return true if submissions_controller_user__permissions
    return true if users_controller_users_permissions
    return true if companies_controller_users_permissions
    return true if jobs_controller_users_permissions
  end

  def everybody_permissions
    return true if sessions_controller_permissions
    return true if favorites_controller_permissions
    return true if contact_us_controller_permissions
    return true if search_controller_permissions
    return true if home_controller_permissions
    return true if company_jobs_controller
  end

  def sessions_controller_permissions
    controller == "sessions" && action.in?(%w(new create destroy))
  end

  def user_jobs_controller_permissions
    controller == "users_jobs" && action.in?(%w(new create show))
  end

  def favorites_controller_permissions
    controller == "favorites" && action.in?(%w(create show destroy))
  end

  def saved_favorites_controller_permissions
    controller == "saved_favorites" && action.in?(%w(create index destroy))
  end

  def company_jobs_controller
    controller == "company/jobs" && action.in?(%w(show))
  end

  def search_controller_permissions
    controller == "search"  && action.in?(%w(show))
  end

  def submissions_controller_user__permissions
    controller == "submissions" && action.in?(%w(new create))
  end

  def submissions_controller_platform_admin_permissions
    controller == "submissions" && action.in?(%w(index new create show edit update approved_index denied_index approved_submissions denied_submissions))
  end

  def home_controller_permissions
    controller == "home"  && action.in?(%w(index about_us))
  end

  def contact_us_controller_permissions
    controller == "contact_us"  && action.in?(%w(new create))
  end

  def contact_us_controller_platform_admin_permissions
    controller == "contact_us"  && action.in?(%w(index new create show delete))
  end

  def users_controller_users_permissions
    controller == "users" && action.in?(%w(new create show edit update))
  end

  def users_controller_store_admin_permissions
    controller == "users" && action.in?(%w(new create show edit update destroy admin_index))
  end

  def users_controller_platform_admin_permissions
    controller == "users" && action.in?(%w(index new create show edit update delete admin_index))
  end

  def companies_controller_users_permissions
    controller == "companies"  && action.in?(%w(index show))
  end

  def companies_controller_store_admin_permissions
    controller == "companies"  && action.in?(%w(index show edit update))
  end

  def companies_controller_platform_admin_permissions
    controller == "companies"  && action.in?(%w(index new create show active_companies inactive_companies inactivate_company activate_company edit update))
  end

  def jobs_controller_users_permissions
    controller == "jobs"  && action.in?(%w(index show))
  end

  def jobs_controller_admins_permissions
    controller == "jobs"  && action.in?(%w(index new create show edit update destroy store_jobs))
  end

  def controller
    @_controller
  end

  def action
    @_action
  end

  def user
    @_user
  end

end
