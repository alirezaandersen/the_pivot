require 'rails_helper'

RSpec.feature "Visitor can view all tasks" do
  scenario "they see the names of all tasks" do
    tasks = create_list(:task, 3)

    visit tasks_path

    expect(page).to have_content "2 Task"
    expect(page).to have_content "3 Task"
    expect(page).to have_content "4 Task"
  end
end
