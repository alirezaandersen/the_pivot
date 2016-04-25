require 'rails_helper'

RSpec.feature "User can view past commitments" do
  scenario "they can visit their past commitments page" do
    volunteer = create(:volunteer_with_tasks)
    first_task, last_task = volunteer.tasks

    login_volunteer(volunteer)
    cart_checkout

    within(".upcoming-table") do
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
    cart_checkout

    within(".upcoming-table") do
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

  scenario "they can view details of an individual pledged task" do
    volunteer = create(:volunteer_with_tasks)
    first_task, last_task = volunteer.tasks

    login_volunteer(volunteer)

    cart_checkout

    visit commitments_path(volunteer)

    within(page.all("#task-status")[0]) do
      expect(page).to have_content("pledged")
    end

    within(page.all("#task-pledge-date")[0]) do
      expect(page).to have_content("#{first_task.pledge_date}")
    end

    page.all(".upcoming-table")[0].click_link("#{first_task.name}")

    expect(page).to have_current_path(task_path(first_task))

    expect(page).to have_content("Status: pledged")
    expect(page).to have_content("#{first_task.hours}")
  end

  scenario "they can navigate back to commitments page" do
    volunteer = create(:volunteer_with_tasks)
    first_task, last_task = volunteer.tasks

    login_volunteer(volunteer)

    cart_checkout

    visit commitments_path(volunteer)

    page.all(".upcoming-table")[0].click_link("#{first_task.name}")

    expect(page).to have_current_path(task_path(first_task))
    expect(page).to have_button("Back to Commitments")

    click_button("Back to Commitments")

    expect(page).to have_current_path(commitments_path)
  end

  def login_volunteer(volunteer)
    visit login_path
    fill_in "Username", with: volunteer.username
    fill_in "Password", with: volunteer.password
    click_button("LOGIN")
  end

  def cart_checkout
    visit tasks_path
    page.all(".card-action")[0].click_link("Add to Cart")
    page.all(".card-action")[1].click_link("Add to Cart")

    within(".main-resources") do
      click_on("Cart: 2")
    end

    click_on("Checkout")
  end
end
