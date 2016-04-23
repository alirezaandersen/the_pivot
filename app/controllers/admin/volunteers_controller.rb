class Admin::VolunteersController < Admin::BaseController

  def show
    @admin = current_volunteer
  end

end
