require 'rails_helper'


RSpec.feature "Store Admin can create another store admin for their store" do
  scenario "Store Admin creates another admin for their store" do

    user = store_admin_user
    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path store_admin_dashboard_path

    click_link("Create Administrator")

    expect(page).to have_current_path new_admin_user_path(user.company_id)

    fill_in "First Name", with: "Register"
    fill_in "Last Name", with: "User"
    fill_in "Email", with: "registered@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"

    click_on "CREATE ACCOUNT"

    expect(page).to have_current_path store_admin_dashboard_path
    expect(page).to have_content("Welcome Register")
  end
end
