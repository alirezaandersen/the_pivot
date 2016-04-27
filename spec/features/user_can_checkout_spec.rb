require 'rails_helper'

RSpec.feature "User can checkout tasks" do
  scenario "they can checkout tasks" do
    volunteer = create(:volunteer)
    create(:city_with_tasks)

    task_1, task_2 = Task.all.take(2)

    visit tasks_path

    within(".main-resources") do
      expect(page).to have_content("Cart: 0")
      expect(page).to have_content("LOGIN")
    end

    page.all(".card-action")[0].click_link("Add to Cart")
    page.all(".card-action")[1].click_link("Add to Cart")

    within(".main-resources") do
      click_on("Cart: 2")
    end

    expect(page).to have_current_path("/cart")
    expect(page).to_not contain_exactly("Checkout")
    click_button("Login or Create Account to Checkout")

    login_volunteer(volunteer)

    within(".main-resources") do
      expect(page).to have_content("LOGOUT")
    end

    expect(page).to have_current_path("/cart")
    expect(page).to have_content("#{task_1.name}")
    expect(page).to have_content("#{task_2.name}")

    click_on("Checkout")

    expect(page).to have_current_path("/commitments")

    within(".flash-notice") do
      expect(page).to have_content("You're Committed!")
    end

    within(".upcoming-table") do
      expect(page).to have_content("#{task_1.name}")
      expect(page).to have_content("#{task_2.name}")
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
