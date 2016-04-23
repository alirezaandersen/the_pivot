require 'rails_helper'

RSpec.feature "User can view retired items" do
  scenario "they can visit retired items page" do
    city = create(:city_with_tasks)
    task = city.tasks.last
    task.update_attributes(status: "retired")

    visit task_path(task)

    expect(page).to have_content("Task Retired")
    expect(page).to_not have_content("Add to Cart")
  end
end
