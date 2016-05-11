require 'rails_helper'

RSpec.feature "Visitor log in" do
  scenario "they can log in from the home index" do
    user = FactoryGirl.create(:user, password: "password")

    visit root_path

    within(".main-resources") do
        click_link "LOGIN/REGISTER"
    end
    assert '/login', current_path

    expect(page).to have_content("Welcome!")
    expect(page).to have_content("LOGIN")
    expect(page).to have_content("REGISTER")

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    assert user_path(user.id), current_path

    expect(page).to have_content("Welcome #{user.first_name}")
    expect(page).to have_content("Email: #{user.email}")
  end

  scenario "Unregistered Vistor cannot log in" do
    user = FactoryGirl.create(:user, password: "password")
    visit root_path

    within(".main-resources") do
        click_link "LOGIN/REGISTER"
    end

    expect(page).to have_content("Welcome!")
    expect(page).to have_content("LOGIN")
    expect(page).to have_content("REGISTER")

    fill_in "Email", with: user.email
    fill_in "Password", with: "Invalidpassword1234"

    click_on "LOGIN"

    expect(page).to have_content("Invalid. Please try again.")

    assert login_path, current_path
  end

  scenario "Vistor can Register with Valid credentials" do
    user = FactoryGirl.create(:user, password:"password")
    visit root_path

    within(".main-resources") do
        click_link "LOGIN/REGISTER"
    end

    click_link "REGISTER"

    assert new_user_path, current_path

    expect(page).to have_content("Create Account")

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: "#{user.email}+#{rand(999)}"
    fill_in "Password", with: user.password
    fill_in "Confirm Password", with: user.password

    click_on "CREATE ACCOUNT"

    assert user_path(user.id), current_path

    expect(page).to have_content("Welcome #{user.first_name}")
    expect(page).to have_content("Email: #{user.email}")
  end

  scenario "Vistor cannot Register with invalid credentials" do
    user = FactoryGirl.create(:user, password:"password")
    visit root_path

    within(".main-resources") do
        click_link "LOGIN/REGISTER"
    end

    click_link "REGISTER"

    assert new_user_path, current_path

    expect(page).to have_content("Create Account")

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Confirm Password", with: user.password
    # byebug
    click_on "CREATE ACCOUNT"

    expect(page).to have_content("Invalid. Please try again.")

    assert new_user_path, current_path

  end



end
