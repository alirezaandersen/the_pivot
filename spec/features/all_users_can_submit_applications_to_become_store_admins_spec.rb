require 'rails_helper'

RSpec.feature "All users can submit application to become store admin" do
  scenario "Any user can submit application" do

  visit root_path

  within("footer") do
      click_link "Recruit With Us"
  end

  expect(page).to have_current_path submissions_path

  fill_in 'Company Name', with: "Ziba"
  fill_in 'Company Logo', with: "https://s3.graphiq.com/sites/default/files/465/media/images/t2/Labrador_Retriever_4922658.jpg"
  fill_in 'Company url', with: "labrador.com"
  fill_in 'Company Size', with: "15"
  fill_in 'Company Industry', with: "Doggie Builders"
  fill_in 'Tell Us About Your Company', with: "We Build Dog homes"
  fill_in 'First Name', with: "Ziba"
  fill_in 'Last Name', with: "Andersen"
  fill_in 'Email', with: "#{rand(999)}@puppy.com"
  fill_in 'Phone Number', with: "1-800-woo ooof"
  fill_in "Describe Your Companies Culture", with: "chasing cats and finding bones"

  click_on "SUBMIT APPLICATION"

  redirect_to root_path

  expect(page).to have_current_path root_path
  expect(page).to have_content("Thank you for your interest. A Ziba specialist will reach out to you soon")
  end

  scenario "Application cannot be submmit twice" do
    submissions = create(:submission)

  visit root_path

  within("footer") do
      click_link "Recruit With Us"
  end

  expect(page).to have_current_path submissions_path

  fill_in 'Company Name', with: submissions.company_name
  fill_in 'Company Logo', with: submissions.logo
  fill_in 'Company url', with: submissions.url
  fill_in 'Company Size', with: submissions.size_of_company
  fill_in 'Company Industry', with: submissions.industry
  fill_in 'Tell Us About Your Company', with: submissions.about_company
  fill_in 'First Name', with: submissions.first_name
  fill_in 'Last Name', with: submissions.last_name
  fill_in 'Email', with: submissions.email
  fill_in 'Phone Number', with: submissions.phone_number
  fill_in "Describe Your Companies Culture", with: submissions.description

  click_on "SUBMIT APPLICATION"

  expect(page).to have_current_path submissions_path
  # save_and_open_page
  expect(page).to have_content("Invalid Info. Please try again")

  end

end
