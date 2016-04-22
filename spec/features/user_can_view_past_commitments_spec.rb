require 'rails_helper'

# Background: An existing user that has multiple orders
#       As an Authenticated User
#       When I visit "/commitments"
#       Then I should see all commitments belonging to me and no other orders

RSpec.feature do "User can view past commitments" do
  scenario "they can visit their past commitments page" do
    # create commitments -- assign volunteer_id to tasks
    volunteer = create(:volunteer_with_tasks)
    login_user(volunteer)

    visit commitments_path(user)

    expect(page).to have_content(volunteer.tasks.first.name)
    expect(page).to have_content(volunteer.tasks.last.name)
  end

  scenario "they cannot view past commitments belonging to another user" do
    # create second user
    #expect page to now show commitment info belonging to second user
  end

  def login_volunteer(volunteer)
    visit login_path

    fill_in "Username", with: volunteer.username
    fill_in "Password", with: volunteer.password
    click_on("LOGIN")
  end
end
