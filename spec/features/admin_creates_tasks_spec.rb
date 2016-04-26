require 'rails_helper'

RSpec.feature "Admin creates tasks" do
  scenario "They log in and create a task" do
    skip
    admin = Volunteer.create(first_name: "John",
                             last_name: "Last",
                             username: "admin",
                             email: "admin@me.com",
                             password: "password",
                             role: 1
                             )
    visit login_path

    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_button("LOGIN")

    click_on("Create a New Task")

    expect(page).to have_current_path("/admin/tasks/new")
    fill_in "Name", with: "New Task"
    fill_in "Description", with: "Come help us"
    fill_in "Date", with: "04/03/2017"
    fill_in "Start Time", with: "5:00 PM"
    fill_in "Hours", with: 3
    fill_in "City", with: "Denver"
    #paperclip???? how do we test for attaching an image
    #do we want a number of volunteers attribute?
    click_on("Create this Task!")

    expect(page).to have_current_path(admin_dashboard_path)
    expect(page).to have_content("Task Successfully Created!")

    visit tasks_path
    expect(page).to have_content("New Task")
  end
end
# - An item must have a title, description and price.
#   - An item must belong to at least one category.
#   - The title and description cannot be empty.
#   - The title must be unique for all items in the system.
#   - The price must be a valid decimal numeric value and greater than zero.
#   - The photo is optional. If not present, a stand-in photo is used. **
