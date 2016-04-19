require 'rails_helper'

RSpec.feature "Visitor can add tasks to cart" do
  scenario "they visit the index page and add a task" do

    create(:city_with_tasks)
    # task = Task.first

    visit tasks_path
    expect(page).to have_content("Cart: 0")
    first(".card-action").click_link("Add to Cart")

    expect(page).to have_content("Task added!")
    expect(page).to have_content("Cart: 1")
    # When I visit any page with an item on it
    # I should see a link or button for "Add to Cart"
    # When I click "Add to cart" for that item
  end

  scenario "they can view contents of cart" do
    create(:city_with_tasks)
    task = Task.all.first

    visit tasks_path

    first(".card-action").click_link("Add to Cart")

    click_on("Cart:")

    expect(page).to have_current_path("/cart")
    expect(page).to have_content task.name
    expect(page).to have_content task.description
    expect(page).to have_content task.hours
    expect(page).to have_css("img[src*='#{task.image_path}']")
  end

  scenario "they can see total hours of tasks" do
    create(:city_with_tasks)

    visit tasks_path

    first(".card-action").click_link("Add to Cart")
    page.all(".card-action")[1].click_link("Add to Cart")

    click_on("Cart:")

    expect(page).to have_content("Total Hours: 5")
  end


  # And there should be a "total" price for the cart that should be the sum of all items in the cart

end
