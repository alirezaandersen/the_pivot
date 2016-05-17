require 'rails_helper'


RSpec.feature "Platform Admin can see company applicants" do
  scenario "Platform Admin can see companies pending submissions" do

    user = platform_admin_user
    applicant = create(:submission)

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    click_link("Company Applicants")

    expect(page).to have_content("Pending Submissions")
    expect(page).to have_content("#{applicant.company_name}")
    expect(page).to have_content("#{applicant.description}")

  end
end
