# require 'rails_helper'
#
# RSpec.feature "User can view task" do
#
#   scenario "they click on task image to get to show page" do
#     city = create(:city_with_tasks)
#     task = city.tasks.first
#
#     visit tasks_path
#
#     first(:link, task.name).click
#
#     expect(page).to have_current_path(task_path(task))
#   end
#
#   scenario "they can see tasks info" do
#     city = create(:city_with_tasks)
#     task = city.tasks.first
#
#     visit task_path(task)
#
#     expect(page).to have_content("#{task.name} in #{city.name}")
#     expect(page).to have_content(task.description)
#     expect(page).to have_content(task.display_time)
#     expect(page).to have_content(task.date)
#   end
# end
