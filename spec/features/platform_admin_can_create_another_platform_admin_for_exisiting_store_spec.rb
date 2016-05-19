require 'rails_helper'


RSpec.feature "Platform Admin can create another store admin for existing company clients" do
  scenario "Platform Admin can create exisiting additional store admin for exisiting store" do

    user = platform_admin_user
    company = create(:company)
     company.update(approve: true)

     Role.create(name: "store_admin")
     store_user = create(:user)
     store_user.roles << Role.find_by(name: "store_admin")

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    click_link("Available Companies")

    expect(page).to have_current_path active_companies_path

    expect(page).to have_content("Active Companies")
    expect(page).to have_content("Total Active Companies")

    click_on "CREATE ADMIN"

    expect(page).to have_content("Create Account")
    expect(page).to have_current_path new_admin_user_path(company.id)

    fill_in "First Name", with: store_user.first_name
    fill_in "Last Name", with: store_user.last_name
    fill_in "Email", with: store_user.email
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"

    click_on "CREATE ACCOUNT"

    expect(page).to have_content("Welcome ")
  end
end
