require 'rails_helper'

RSpec.feature "Admin creates tasks" do
  include UserHelpers

  scenario "They log in and create a task" do
    city  = create(:city)

    create_and_login_admin

    click_link("Create a New Task")

    expect(page).to have_current_path("/admin/tasks/new")
    fill_in "Name", with: "New Task"
    fill_in "Description", with: "Come help us"
    fill_in "Date", with: "04/03/2017"
    fill_in "Start Time", with: "5:00 PM"
    fill_in "Hours", with: 3
    fill_in "Street Address (e.g., 1234 Main Street)", with: "2000 Elitch Cir"
    fill_in "Zip Code (e.g., 80204)", with: "80204"
    select("#{city.name_and_state}", from: 'task_city_id')
    attach_file("task[image]", 'app/assets/images/full_placeholder.png')

    click_button("Create this Task")

    expect(Task.last.address).to eql("2000 Elitch Cir")
    expect(page).to have_current_path(task_path(1))
    expect(page).to have_content("Task Created!")

    visit tasks_path

    expect(page).to have_content("New Task")
  end
end
