require 'rails_helper'

RSpec.feature "User creates account" do
  scenario "they create a new account" do
    visit tasks_path
    
    click_on("LOGIN")
    expect(page).to have_current_path('/login')
    expect(page).to have_link('SIGN UP')

    click_on("SIGN UP")

    expect(page).to have_current_path(new_volunteer_path)
    fill_in "First Name", with: "Bob"
    fill_in "Last Name", with: "Builder"
    fill_in "Username", with: "bobthebuilder"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    fill_in "Email", with: "bob@gmail.com"

    click_on("Create Account")

    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content("Logged in as bobthebuilder")
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Login')
    expect(page).to have_content("Bob")
    expect(page).to have_content("bob@gmail.com")
  end
end
