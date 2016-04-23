require 'rails_helper'

RSpec.feature "User can checkout tasks" do
  scenario "they can checkout tasks" do
    volunteer = create(:volunteer)
    create(:city_with_tasks)

    visit tasks_path

    expect(page).to have_content("Cart: 0")
    expect(page).to have_content("LOGIN")

    page.all(".card-action")[0].click_link("Add to Cart")
    page.all(".card-action")[1].click_link("Add to Cart")

    click_on("Cart: 2")

    expect(page).to have_current_path("/cart")
    expect(page).to_not contain_exactly("Checkout")
    click_button("Login or Create Account to Checkout")

    login_volunteer(volunteer)

    expect(page).to have_current_path("/cart")
    expect(page).to have_content("LOGOUT")

    expect(page).to have_content("Task 1")
    expect(page).to have_content("Task 2")

    click_on("Checkout")

    expect(page).to have_current_path("/commitments")

    within(".flash-notice") do
      expect(page).to have_content("Commitment was successfully placed")
    end

    within(".commitment-table") do
      expect(page).to have_content("Task 1")
      expect(page).to have_content("Task 2")
    end

    expect(page).to have_content("Cart: 0")
  end

  def login_volunteer(volunteer)
    visit login_path
    fill_in "Username", with: volunteer.username
    fill_in "Password", with: volunteer.password
    click_button("LOGIN")
  end
end
