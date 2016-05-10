# require 'rails_helper'
#
# RSpec.feature "User creates account" do
#   scenario "they create a new account" do
#     visit tasks_path
#
#     within(".main-resources") do
#       click_link("LOGIN")
#     end
#
#     expect(page).to have_current_path('/login')
#     expect(page).to have_link('SIGN UP')
#
#     click_on("SIGN UP")
#
#     expect(page).to have_current_path(new_volunteer_path)
#     fill_in "First Name", with: "Bob"
#     fill_in "Last Name", with: "Builder"
#     fill_in "Username", with: "bobthebuilder"
#     fill_in "Password", with: "password"
#     fill_in "Confirm Password", with: "password"
#     fill_in "Email", with: "bob@gmail.com"
#
#     click_on("Create Account")
#
#     within(".flash-notice") do
#       expect(page).to have_content("Logged in as bobthebuilder")
#     end
#
#     visit dashboard_path
#     expect(page).to have_current_path('/dashboard')
#     expect(page).to have_content("Bob")
#     expect(page).to have_content("bob@gmail.com")
#   end
#
#   scenario "they can logout after logging in" do
#     volunteer = create(:volunteer)
#
#     visit tasks_path
#
#     within(".main-resources") do
#       click_link("LOGIN")
#     end
#
#     expect(page).to have_current_path('/login')
#
#     fill_in "Username", with: volunteer.username
#     fill_in "Password", with: volunteer.password
#     click_button("LOGIN")
#
#     within(".flash-notice") do
#       expect(page).to have_content("Logged in as #{volunteer.username}")
#     end
#
#     expect(page).to have_current_path('/dashboard')
#     expect(page).to have_content(volunteer.first_name)
#     expect(page).to have_content(volunteer.email)
#
#     within(".main-resources") do
#       expect(page).to have_link('LOGOUT')
#       expect(page).to_not have_link('LOGIN')
#
#       click_link("LOGOUT")
#     end
#
#     within(".flash-notice") do
#       expect(page).to have_content("Logged out!")
#     end
#   end
#
#   scenario "they create account from cart and are redirect_to cart" do
#     create(:city_with_tasks)
#     visit tasks_path
#
#     page.all(".card-action")[0].click_link("Add to Cart")
#
#     visit cart_path
#     click_on("Login or Create Account to Checkout")
#
#     expect(page).to have_current_path('/login')
#
#     click_on("SIGN UP")
#
#     fill_in "First Name", with: "Bob"
#     fill_in "Last Name", with: "Builder"
#     fill_in "Username", with: "bobthebuilder"
#     fill_in "Password", with: "password"
#     fill_in "Confirm Password", with: "password"
#     fill_in "Email", with: "bob@gmail.com"
#
#     click_on("Create Account")
#
#     expect(page).to have_current_path(cart_path)
#   end
# end
