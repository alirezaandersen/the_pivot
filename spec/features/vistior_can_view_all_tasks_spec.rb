require 'rails_helper'

RSpec.feature "Visitor can view all tasks" do

  scenario "they see the names of all tasks" do
    city = create(:city_with_tasks)

    visit tasks_path

    city.tasks.each do |task|
      expect(page).to have_content task.name
      expect(page).to have_content task.description
      expect(page).to have_content task.hours
      expect(page).to have_css("img[src*='#{task.image_path}']")
    end
  end

  scenario "they see tasks by city" do
    city = create(:city_with_tasks)

    visit "/#{city.name}"

    city.tasks.each do |task|
      expect(page).to have_content task.name
      expect(page).to have_content task.description
      expect(page).to have_content task.hours
      expect(page).to have_css("img[src*='#{task.image_path}']")
    end
  end
end
