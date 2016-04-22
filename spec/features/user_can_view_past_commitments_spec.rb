require 'rails_helper'

RSpec.feature "User can view past commitments" do
  scenario "they can visit their past commitments page" do
    skip
    volunteer = create(:volunteer_with_tasks)
    first_task = volunteer.tasks.first.name
    last_task = volunteer.tasks.last.name

    login_volunteer(volunteer)

    visit commitments_path(volunteer)

    expect(page).to have_content(first_task)
    expect(page).to have_content(last_task)
  end

  def login_volunteer(volunteer)
    visit login_path
    fill_in "Username", with: volunteer.username
    fill_in "Password", with: volunteer.password
    click_button("LOGIN")
  end
end
