require 'rails_helper'

RSpec.feature "User can checkout tasks" do
  scenario "they can checkout tasks " do
    create(:city_with_tasks)

    visit tasks_path

    page.all(".card-action")[0].click_link("Add to Cart")
    page.all(".card-action")[1].click_link("Add to Cart")

    click_on("Cart:")

    click_button("Login or Create Account to Checkout")

    click_on("SIGN UP")

    expect(page).to have_current_path(new_volunteer_path)
    fill_in "First Name", with: "Bob"
    fill_in "Last Name", with: "Builder"
    fill_in "Username", with: "bobthebuilder"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    fill_in "Email", with: "bob@gmail.com"

    click_on("Create Account")

    click_on("Cart:")

    click_on("Checkout")

    expect(page).to have_current_path("/orders")

    within(".flash-notice") do
      expect(page).to have_content("Order was successfully placed")
    end
  end
end

# Background: An existing user and a cart with items
#       As a visitor
#       When I add items to my cart
#       And I visit "/cart"
#       And I click "Login or Register to Checkout"
#       Then I should be required to login
#       When I am logged in I should be taken back to my cart
#       And when I click "Checkout"
#       Then the order should be placed
#       And my current page should be "/orders"
#       And I should see a message "Order was successfully placed"
#       And I should see the order I just placed in a table
