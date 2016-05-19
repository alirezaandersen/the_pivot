require 'rails_helper'

RSpec.feature "Platform Admin can aprrove submissions" do
  scenario "Platform Admin approves applicant" do

    user = platform_admin_user
    applicant = create(:submission)
    visit root_path

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    click_link("Company Applicants")

    expect(page).to have_current_path submissions_status_path

    expect(page).to have_content("Pending Submissions")
    click_link "#{applicant.company_name}"

    click_on "Approve Company"

    expect(page).to have_content("Approved Submissions")
    expect(page).to have_content("#{applicant.company_name}")
    expect(page).to have_content("#{applicant.description}")
  end
end
