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

    within(".flash-notice") do
      expect(page).to have_content("Logged in as bobthebuilder")
    end

    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content("Bob")
    expect(page).to have_content("bob@gmail.com")
  end

  scenario "they can logout after logging in" do
    volunteer = create(:volunteer)

    visit tasks_path

    click_on("LOGIN")
    expect(page).to have_current_path('/login')

    fill_in "Username", with: volunteer.username
    fill_in "Password", with: volunteer.password
    click_button("LOGIN")

    within(".flash-notice") do
      expect(page).to have_content("Logged in as #{volunteer.username}")
    end

    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content(volunteer.first_name)
    expect(page).to have_content(volunteer.email)

    expect(page).to have_link('LOGOUT')
    expect(page).to_not have_link('LOGIN')

    click_on("LOGOUT")

    within(".flash-warning") do
      expect(page).to have_content("Logged out!")
    end
  end
end
