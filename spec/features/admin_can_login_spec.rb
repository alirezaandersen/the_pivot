require 'rails_helper'

RSpec.feature "Admin can login" do
  scenario "they can login and see admin/dashoboard page" do
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

    expect(page).to have_current_path(admin_dashboard_path)
  end
end
