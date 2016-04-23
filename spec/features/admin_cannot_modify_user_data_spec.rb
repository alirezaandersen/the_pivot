require 'rails_helper'

RSpec.feature "Admin can modify account data" do
  scenario "admin modifies their data" do
    admin = Volunteer.create(first_name: "admin",
                             last_name: "Last",
                             username: "admin",
                             email: "admin@me.com",
                             password: "password",
                             role: 1
                             )
    visit login_path

    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_button("LOGIN")

    click_on("Edit your account info")
    expect(page).to have_current_path(admin_edit_path)

    fill_in "First Name", with: "Bob"
    fill_in "Last Name", with: "Builder"
    fill_in "Username", with: "bobthebuilder"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    fill_in "Email", with: "bob@gmail.com"

    click_on("Save Changes")

    expect(page).to have_current_path(admin_dashboard_path)

    expect(page).to have_content("Welcome Bob")
    expect(page).to have_content("Your Account Has Been Updated")
  end
end
