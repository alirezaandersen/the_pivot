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
    return true if controller == "sessions"
    return true if controller == "jobs"  && action.in?(%w(index new create show edit update delete))
    return true if controller == "users_jobs" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(index new create show edit update delete))
    return true if controller == "companies"  && action.in?(%w(index new create show edit update delete pending_show pending_index))
    return true if controller == "contact_us"  && action.in?(%w(index new create show delete))
    return true if controller == "favorites"  && action.in?(%w(create show delete))
    return true if controller == "home"  && action.in?(%w(index about_us))
    return true if controller == "submissions" && action.in?(%w(index new create show edit update approved_index denied_index approved_submissions denied_submissions))
    return true if controller == "search"  && action.in?(%w(show))
  end

  def store_admin_permissions
    return true if controller == "sessions"
    return true if controller == "jobs"  && action.in?(%w(index new create show edit update destroy))
    return true if controller == "users_jobs" && action.in?(%w(index show))
    return true if controller == "users" && action.in?(%w(index new create show edit update destroy))
    return true if controller == "companies"  && action.in?(%w(index show))
    return true if controller == "contact_us"  && action.in?(%w(new create))
    return true if controller == "favorites"  && action.in?(%w(create show destroy))
    return true if controller == "home"  && action.in?(%w(index about_us))
    return true if controller == "search"  && action.in?(%w(show))
  end

  def registered_user_permissions
    return true if controller == "sessions"
    return true if controller == "jobs"  && action.in?(%w(index show))
    return true if controller == "companies"  && action.in?(%w(index show))
    return true if controller == "favorites_jobs"  && action.in?(%w(create show destroy))
    return true if controller == "contact_us"  && action.in?(%w(new create))
    return true if controller == "users" && action.in?(%w(index new create show edit update))
    return true if controller == "home"  && action.in?(%w(index about_us))
    return true if controller == "search"  && action.in?(%w(show))
  end

  def guest_permissions
    return true if controller == "companies"  && action.in?(%w(index show))
    return true if controller == "home"  && action.in?(%w(index about_us))
    return true if controller == "contact_us"  && action.in?(%w(new create))
    return true if controller == "jobs"  && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "favorites_jobs"  && action.in?(%w(create show destroy))
    return true if controller == "users" && action.in?(%w(index new create show edit update))
    return true if controller == "submissions" && action.in?(%w(new create))
    return true if controller == "search"  && action.in?(%w(show))
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
