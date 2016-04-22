require 'rails_helper'

RSpec.feature "Visitor can view cart but not checkout" do
  scenario "they view the cart without logging in" do
    create(:city_with_tasks)
    task = Task.all.first

    visit tasks_path

    first(".card-action").click_link("Add to Cart")

    click_link("Cart: 1")

    expect(page).to_not contain_exactly("Checkout")
    expect(page).to have_current_path("/cart")
    expect(page).to have_content task.name
    expect(page).to have_content task.description
    expect(page).to have_content task.hours
    expect(page).to have_button("Login or Create Account to Checkout")

    click_button("Login or Create Account to Checkout")
    expect(page).to have_current_path(login_path)

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

    click_on "Cart:"
    expect(page).to have_current_path(cart_path)
    expect(page).to have_current_path("/cart")
    expect(page).to have_content task.name
    expect(page).to have_content task.description
    expect(page).to have_content task.hours

    expect(page).to have_button("Checkout")
    expect(page).to have_link("LOGOUT")
    expect(page).to_not have_link("LOGIN")
    expect(page).to_not have_button("Login or Create Account to Checkout")

    click_link "LOGOUT"

    expect(page).to have_current_path(root_path)
    expect(page).to have_link("LOGIN")
    expect(page).to_not have_link("LOGOUT")
  end
end
