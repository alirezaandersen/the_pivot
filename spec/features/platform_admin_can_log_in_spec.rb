require 'rails_helper'


RSpec.feature "Platform Admin Can log in" do
  scenario "Platform Admin can log in and see their dashboard" do

    user = platform_admin_user

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    expect(page).to have_content("Welcome Super #{user.first_name}")
    expect(page).to have_content("Email: #{user.email}")

    expect(page).to have_link("Customer Inquiries")
    expect(page).to have_link("Company Applicants")
    expect(page).to have_link("Approved Companies")
    expect(page).to have_link("Denied Companies")
    expect(page).to have_link("Avaiable Companies")
    expect(page).to have_link("Inactive Companies")
    expect(page).to have_link("View all Users")
    expect(page).to have_link("View all Jobs")
  end
end
