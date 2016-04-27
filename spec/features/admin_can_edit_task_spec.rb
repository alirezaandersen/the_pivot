require 'rails_helper'

RSpec.feature "Admin edits tasks" do
  scenario "They log in and edit a task" do
    city  = create(:city)
    task  = create(:task)
    admin = Volunteer.create(first_name: "John",
                             last_name:  "Last",
                             username:   "admin",
                             email:      "admin@me.com",
                             password:   "password",
                             role:       1)
    visit login_path

    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_button("LOGIN")

    visit task_path(task.id)

    click_link("Edit Task")

    expect(page).to have_current_path("/admin/tasks/#{task.id}/edit")
    fill_in "Name", with: "Updated Task"
    fill_in "Description", with: "Come help us"
    fill_in "Hours", with: 15
    select("#{city.name_and_state}", from: 'task_city_id')

    click_button("Update Task")

    expect(page).to have_current_path(task_path(task.id))
    expect(page).to have_content("Task Updated!")

    within(".card-panel") do
      expect(page).to have_content("Updated Task")
      expect(page).to have_content("Come help us")
      expect(page).to have_content("Hours: 15")
      expect(page).to have_content("#{city.name_and_state}")
    end
  end

end
