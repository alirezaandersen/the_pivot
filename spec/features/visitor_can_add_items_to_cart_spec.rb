require 'rails_helper'

RSpec.feature "Visitor can add tasks to cart" do
  scenario "they visit the index page and add a task" do
    create(:city_with_tasks)

    visit tasks_path
    expect(page).to have_content("Cart: 0")
    first(".card-action").click_link("Add to Cart")

    expect(page).to have_content("Task added!")
    expect(page).to have_content("Cart: 1")
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

    expect(page).to have_content("Total Hours: 3")
  end

  scenario "they cannot add the same task to a cart twice" do
    create(:city_with_tasks)

    visit tasks_path
    page.all(".card-action")[0].click_link("Add to Cart")
    page.all(".card-action")[1].click_link("Add to Cart")

    expect(page).to have_content("Cart: 2")

    page.all(".card-action")[1].click_link("Add to Cart")

    expect(page).to have_content("Cart: 2")
    expect(page).to have_content("Task is already in your Cart!")
  end

  scenario "they can remove an item from the cart" do
    create(:city_with_tasks)
    task = Task.all.first

    visit tasks_path
    page.all(".card-action")[0].click_link("Add to Cart")
    page.all(".card-action")[1].click_link("Add to Cart")

    click_on("Cart:")
    expect(page).to have_content("Total Hours: 4")

    page.all(".card-action")[0].click_link("Remove from Cart")

    expect(page).to have_content("Total Hours: 2")
    expect(page).not_to have_content(task.name)
  end
end
