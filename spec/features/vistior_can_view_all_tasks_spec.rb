require 'rails_helper'

RSpec.feature "Visitor can view all tasks" do
  scenario "they see the names of all tasks" do
    tasks = create_list(:task, 3)

    visit tasks_path

    expect(page).to have_content tasks[0].name
    expect(page).to have_css("img[src*='#{tasks[0].image_path}']")

    expect(page).to have_content tasks[1].name
    expect(page).to have_css("img[src*='#{tasks[1].image_path}']")

    expect(page).to have_content tasks[2].name
    expect(page).to have_css("img[src*='#{tasks[2].image_path}']")
  end

  # scenario "they see tasks by city" do
  #   tasks  = create_list(:task, 3)
  #   cities = create_list(:city, 2)
  # end
end
