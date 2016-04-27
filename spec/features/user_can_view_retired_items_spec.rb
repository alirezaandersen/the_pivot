require 'rails_helper'

RSpec.feature "User can view retired items" do
  scenario "they can visit retired items page" do
    city = create(:city_with_tasks)
    task = city.tasks.last
    task.update_attributes(status: "retired")
    visit task_path(task)

    expect(page).to have_content("retired")
    expect(page).not_to have_content("Add to Cart")
    expect(page).not_to have_content("Back to Commitments")
  end
end
