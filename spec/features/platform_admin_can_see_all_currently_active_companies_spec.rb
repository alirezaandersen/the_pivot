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

    expect(page).to have_content("Active Companies")
    expect(page).to have_content("Total Active Companies")

    within('#active-companies-card') do
      expect(page).to have_link("CREATE JOB")
      expect(page).to have_link("EDIT JOB")
      expect(page).to have_link("CREATE ADMIN")
      expect(page).to have_link("UPDATE COMPANY INFORMATION")
      expect(page).to have_link("VIEW ADMINISTRATION STAFF")
      expect(page).to have_link("INACTIVATE COMPANY")
    end
  end
end
