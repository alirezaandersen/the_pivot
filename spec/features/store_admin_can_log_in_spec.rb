require 'rails_helper'


RSpec.feature "Store Admin Can log in" do
  scenario "Store Admin can log in and see their dashboard" do

    user    = store_admin_user
    company = create(:company)

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path store_admin_dashboard_path

    expect(page).to have_content("Welcome to your Store, #{user.first_name}")
    expect(page).to have_content("Email: #{user.email}")

    expect(page).to have_link("Create Job")
    expect(page).to have_link("View Company Jobs")
    expect(page).to have_link("Create Administrator")
    expect(page).to have_link("Update Company Information")
    expect(page).to have_link("View Store Admins")
  end
end
