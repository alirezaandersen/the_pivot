require 'rails_helper'

RSpec.feature "User can view past commitments" do
  scenario "they can visit their past commitments page" do

    volunteer = create(:volunteer_with_tasks)
    first_task, last_task = volunteer.tasks

    login_volunteer(volunteer)

    visit commitments_path(volunteer)

    within(".commitment-table") do
      expect(page).to have_content(first_task.name)
      expect(page).to have_content(first_task.date)
      expect(page).to have_content(first_task.display_time)
      expect(page).to have_content(first_task.hours)
      expect(page).to have_content(first_task.city_id)

      expect(page).to have_content(last_task.name)
      expect(page).to have_content(last_task.date)
      expect(page).to have_content(last_task.display_time)
      expect(page).to have_content(last_task.hours)
      expect(page).to have_content(last_task.city_id)
    end
  end

  scenario "they can only see their own commitments" do
    in_session_volunteer, not_in_session_volunteer = create_list(:volunteer_with_tasks, 2)

    viewable_1, viewable_2 = in_session_volunteer.tasks
    non_viewable_1, non_viewable_2 = not_in_session_volunteer.tasks

    login_volunteer(in_session_volunteer)

    visit commitments_path(in_session_volunteer)

    within(".commitment-table") do
      expect(page).to have_content(viewable_1.name)
      expect(page).to have_content(viewable_1.date)
      expect(page).to have_content(viewable_1.display_time)
      expect(page).to have_content(viewable_1.hours)
      expect(page).to have_content(viewable_1.city_id)

      expect(page).to have_content(viewable_2.name)
      expect(page).to have_content(viewable_2.date)
      expect(page).to have_content(viewable_2.display_time)
      expect(page).to have_content(viewable_2.hours)
      expect(page).to have_content(viewable_2.city_id)
      expect(page).to_not have_content(non_viewable_2.name)
    end
  end

  scenario "they can view details of an individual committed task" do
    volunteer = create(:volunteer_with_tasks)
    first_task, last_task = volunteer.tasks

    login_volunteer(volunteer)
    visit commitments_path(volunteer)

    within(page.all("#task-status")[0]) do
      expect(page).to have_content("Pledged")
    end

    page.all(".commitment-table")[0].click_link("#{first_task.name}")

    expect(page).to have_current_path(task_path(first_task))

    expect(page).to have_content("Status: Pledged")


    expect(page).to have_content("#{first_task.hours}") 
    #expect(page).to have_content(# date/time commitment was submitted)
    # expect(page).to have_content(# completed or cancelled)
    # expect(page).to have_content (when completed or cancelled)

  end

  def login_volunteer(volunteer)
    visit login_path
    fill_in "Username", with: volunteer.username
    fill_in "Password", with: volunteer.password
    click_button("LOGIN")
  end
end
