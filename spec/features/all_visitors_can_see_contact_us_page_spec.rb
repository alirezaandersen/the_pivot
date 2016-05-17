require 'rails_helper'

RSpec.feature "All visitors can use contact us link" do
  scenario "Any user or admin can see contact us page" do

    visit root_path

    within("footer") do
      click_link "Contact Us"
    end

    expect(page).to have_current_path contact_us_path
    expect(page).to have_content("We would love to hear from you")
    expect(page).to have_css('input[type="text"]')
  end

  scenario "Any user or admin can fill out contact us form with valid credentials" do

    visit contact_us_path
    expect(page).to have_current_path contact_us_path

    expect(page).to have_content("We would love to hear from you")
    expect(page).to have_css('input[type="text"]')

    fill_in "First Name", with: "Ali "
    fill_in "Last Name", with: "Andersn"
    fill_in "Email", with: "ali@ali.com"
    fill_in "Phone Number", with: "303-754-5474"
    fill_in "Talk to me!", with: "Yay this works!"

    click_on "SUBMIT"

    expect(page).to have_current_path root_path

    expect(page).to have_content("Thanks for the feedback, we'll be in touch as soon as we can")
  end

  scenario "Any user or admin cannot fill out contact us form with invalid credentials" do

    visit contact_us_path
    expect(page).to have_current_path contact_us_path

    expect(page).to have_content("We would love to hear from you")
    expect(page).to have_css('input[type="text"]')

    fill_in "First Name", with: "Ali "
    fill_in "Last Name", with: "Andersn"
    fill_in "Email", with: "ali@ali.com"
    fill_in "Phone Number", with: " "
    fill_in "Talk to me!", with: "Yay this works!"

    click_on "SUBMIT"

    expect(page).to have_current_path contact_us_path

    expect(page).to have_content("Invalid Info. Please try again.")
  end
end
