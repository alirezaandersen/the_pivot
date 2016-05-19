require 'rails_helper'

RSpec.feature "Platform Admin can aprrove submissions" do
  scenario "Platform Admin approves applicant" do

    user = platform_admin_user

    visit root_path

    expect(page).to have_current_path root_path

    within("footer") do
      click_link "Recruit With Us"
    end

    expect(page).to have_current_path submissions_path

    fill_in "Company Name", with: "Hello"
    fill_in "Company Logo", with: "http://static.businessinsider.com/image/53d29d5c6bb3f7a80617ada8/image.jpg"
    fill_in "Company url", with: "World"
    fill_in "Company Size", with: "100"
    fill_in "Company Industry", with: "Peace"
    fill_in "Tell Us About Your Company", with: "Peace in the World"
    fill_in "First Name", with: "Ali"
    fill_in "Last Name", with: "Jace"
    fill_in "Email", with: "AJ@gmail.com"
    fill_in "Phone Number", with: "555-744-1241"
    fill_in "Describe Your Companies Culture", with: "Joy to the world"

    click_button "SUBMIT APPLICATION"

    expect(page).to have_current_path root_path
    expect(page).to have_content("Thank you for your interest. A Ziba specialist will reach out to you soon")

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    click_link("Company Applicants")

    expect(page).to have_current_path submissions_status_path

    expect(page).to have_content("Pending Submissions")

    click_link "Hello"

    expect(page).to have_current_path company_submission_status_path("Hello")

    click_on "Deny Company"

    expect(page).to have_content("Denied Submissions")
    expect(page).to have_content("Hello")
    expect(page).to have_content("Joy to the world")
  end
end
