require 'rails_helper'


RSpec.feature "Platform Admin can see all inactive companies" do
  scenario "Platform Admin can see inactive companies" do

    user = platform_admin_user
    company = create(:company)

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    click_link("Inactive Companies")

    expect(page).to have_current_path inactive_companies_path
    expect(page).to have_content("Inactive Companies")
    expect(page).to have_content("Total Inactive Companies:")

    expect(page).to have_content("#{company.name}")
    expect(page).to have_button("ACTIVATE COMPANY")
  end
end
