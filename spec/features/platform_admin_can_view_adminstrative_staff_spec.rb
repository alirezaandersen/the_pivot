require 'rails_helper'


RSpec.feature "Platform Admin can see current company clients" do
  scenario "Platform Admin can see companies which are active" do

    user = platform_admin_user
    company = create(:company)
     company.update(approve: true)

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path
    click_link("Available Companies")

    expect(page).to have_current_path active_companies_path

    expect(page).to have_content("#{company.name}")

    expect(page).to have_button("CREATE JOB")
    expect(page).to have_button("EDIT JOB")
    expect(page).to have_button("CREATE ADMINSTRATOR")
    expect(page).to have_button("UPDATE COMPANY INFORMATION")
    expect(page).to have_button("VIEW ADMINISTRATION STAFF")
    expect(page).to have_button("INACTIVATE COMPANY")

    click_button "VIEW ADMINISTRATION STAFF"

    expect(page).to have_content("#{company.name}")
    expect(page).to have_content("Administration")

  end
end
