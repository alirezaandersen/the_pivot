require 'rails_helper'


RSpec.feature "Platform Admin can see all jobs" do
  scenario "Platform Admin can see all jobs" do

    user = platform_admin_user
    jobs = []
    10.times {jobs << create(:job)}
    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    expect(page).to have_content("Welcome Super #{user.first_name}")
    expect(page).to have_content("Email: #{user.email}")

    click_link("View all Jobs")

    expect(page).to have_current_path jobs_path
    expect(page).to have_content("Job Opportunities")
    assert_equal 10, jobs.count
  end
end
