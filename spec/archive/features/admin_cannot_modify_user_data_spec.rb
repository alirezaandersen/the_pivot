# require 'rails_helper'
#
# RSpec.feature "Admin can modify account data" do
#   include UserHelpers
#
#   scenario "admin modifies their data" do
#     create_and_login_admin
#
#     click_on("Edit your account info")
#     expect(page).to have_current_path(admin_edit_path)
#
#     fill_in "First Name", with: "Bob"
#     fill_in "Last Name", with: "Builder"
#     fill_in "Username", with: "bobthebuilder"
#     fill_in "Password", with: "password"
#     fill_in "Confirm Password", with: "password"
#     fill_in "Email", with: "bob@gmail.com"
#
#     click_on("Save Changes")
#
#     expect(page).to have_current_path(admin_dashboard_path)
#
#     expect(page).to have_content("Welcome Bob")
#     expect(page).to have_content("Your Account Has Been Updated")
#   end
#
#   scenario "admin cannot modify other users account data" do
#     volunteer = Volunteer.create(first_name: "Michael",
#                      last_name: "Ldfsdf",
#                      username: "gdsfdin",
#                      email: "fgdsfdn@me.com",
#                      password: "password"
#                                  )
#
#     admin = Volunteer.create(first_name: "admin",
#                              last_name: "Last",
#                              username: "admin",
#                              email: "admin@me.com",
#                              password: "password",
#                              role: 1
#                              )
#     visit login_path
#
#     fill_in "Username", with: admin.username
#     fill_in "Password", with: admin.password
#     click_button("LOGIN")
#
#     visit "/volunteers/#{volunteer.id}/edit"
#
#
#     expect(page).to have_content("The page you were looking for doesn't exist (404)")
#   end
# end
