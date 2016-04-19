require 'rails_helper'

RSpec.feature "Visitor can view all tasks" do

  scenario "they see the names of all tasks" do
    # city = create_list(:city_with_tasks, 1)[0]
    #task = task.create
    #task1, 2, 3 = city.tasks
    create(:city_with_tasks)
    tasks = Task.take(3)

    visit tasks_path

    expect(page).to have_content tasks[0].name
    expect(page).to have_content tasks[0].description
    expect(page).to have_content tasks[0].hours
    expect(page).to have_css("img[src*='#{tasks[0].image_path}']")

    expect(page).to have_content tasks[1].name
    expect(page).to have_content tasks[1].description
    expect(page).to have_content tasks[1].hours
    expect(page).to have_css("img[src*='#{tasks[1].image_path}']")

    expect(page).to have_content tasks[2].name
    expect(page).to have_content tasks[2].description
    expect(page).to have_content tasks[2].hours
    expect(page).to have_css("img[src*='#{tasks[2].image_path}']")
  end

  scenario "they see tasks by city" do
    city = create(:city_with_tasks)

    tasks = Task.take(2)

    visit "/#{city.name}"

    expect(page).to have_content tasks[0].name
    expect(page).to have_content tasks[0].description
    expect(page).to have_content tasks[0].hours
    expect(page).to have_css("img[src*='#{tasks[0].image_path}']")

    expect(page).to have_content tasks[1].name
    expect(page).to have_content tasks[1].description
    expect(page).to have_content tasks[1].hours
    expect(page).to have_css("img[src*='#{tasks[1].image_path}']")
  end
end
