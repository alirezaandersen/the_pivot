require 'rails_helper'

RSpec.feature "User only accesses own information" do
  scenario "visitors cannot access users information" do
    volunteer = create(:volunteer)

    visit dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit commitments_path
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit admin_dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit admin_edit_path
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit new_volunteer_path
    expect(page).not_to have_content("role")
  end

  scenario "authenticated user cannot access others information" do
    volunteer1, volunteer2 = create_list(:volunteer, 2)

    visit login_path

    fill_in "Username", with: volunteer1.username
    fill_in "Password", with: volunteer1.password
    click_button("LOGIN")

    visit admin_dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit admin_edit_path
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit edit_volunteer_path(volunteer2.id)
    expect(page).to have_content("The page you were looking for doesn't exist (404)")
  end
end
#
# Background: An authenticated user and the ability to add an admin user
#       As an Authenticated User
#       I cannot view another user's private data (current or past orders, etc)
#       I cannot view the administrator screens or use admin functionality
#       I cannot make myself an admin
