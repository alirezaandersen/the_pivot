class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: '/public/404' if current_volunteer.nil? || current_volunteer.admin? == false
  end
end
