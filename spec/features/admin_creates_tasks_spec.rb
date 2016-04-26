require 'rails_helper'

RSpec.feature "Admin creates tasks" do
  scenario "They log in and create a task" do
    city  = create(:city)
    admin = Volunteer.create(first_name: "John",
                             last_name: "Last",
                             username: "admin",
                             email: "admin@me.com",
                             password: "password",
                             role: 1)
    visit login_path

    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_button("LOGIN")

    click_link("Create a New Task")

    expect(page).to have_current_path("/admin/tasks/new")
    fill_in "Name", with: "New Task"
    fill_in "Description", with: "Come help us"
    fill_in "Date", with: "04/03/2017"
    fill_in "Start Time", with: "5:00 PM"
    fill_in "Hours", with: 3
    select("#{city.name_and_state}", from: 'task_city_id')

    # paperclip? how do we test for attaching an image

    click_button("Create this Task!")

    expect(page).to have_current_path(city_path(city))
    expect(page).to have_content("Task Created!")

    visit tasks_path
    expect(page).to have_content("New Task")
  end
end
