require 'rails_helper'

RSpec.feature "User cannot view admin dashboard" do
  include UserHelpers

  scenario "visitor recieves a 404 error when visiting admin dashboard" do
    visit "admin/dashboard"

    expect(page).to have_content("The page you were looking for doesn't exist (404)")
  end

  scenario "logged in user receives a 404 error when visiting admin dashboard" do
    volunteer = create(:volunteer)
    login_volunteer(volunteer)
    visit "admin/dashboard"

    expect(page).to have_content("The page you were looking for doesn't exist (404)")
  end
end
