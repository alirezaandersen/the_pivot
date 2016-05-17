require 'rails_helper'


RSpec.feature "Platform Admin can see all users" do
  scenario "Platform Admin can see all users" do

    user = platform_admin_user
    users = []
    10.times {users << create(:user)}
    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    expect(page).to have_content("Welcome Super #{user.first_name}")
    expect(page).to have_content("Email: #{user.email}")

    click_link("View all Users")

    expect(page).to have_current_path view_all_users_path

    expect(page).to have_content("All Ziba Users")
    assert_equal 10, users.count
  end
end
