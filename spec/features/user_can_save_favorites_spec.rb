require 'rails_helper'

RSpec.feature "Registered user can save favorites" do
  include UserHelpers

  scenario "guest user cannot save favorites" do
    job = create(:job)

    visit company_job_path(job.company, job)

    within("#job-text-box") do
      click_link("FAVORITE")
    end

    within(".main-resources") do
      click_on("FAVORITES")
    end
    # save_and_open_page
    expect(page).to have_current_path("/favorites")
    expect(page).to_not contain_exactly("Save your Favorites")
    click_button("Login to save your Favorites")
  end

  scenario "guest user must login or register to save favorites" do
    job = create(:job)
    job.company.update(approve: true)

    user = create(:user)
    user.roles << Role.create(name: "registered_user")

    visit company_job_path(job.company, job)
    within("#job-text-box") do
      click_link("FAVORITE")
    end

    within(".main-resources") do
      click_on("FAVORITES")
    end

    expect(page).to have_current_path("/favorites")
    expect(page).to_not contain_exactly("Save your Favorites")

    click_button("Login to save your Favorites")

    expect(page).to have_current_path(login_path)
    login_user(user)

    expect(page).to have_current_path("/dashboard")

    within(".main-resources") do
      expect(page).to have_content("LOGOUT")
      expect(page).to have_content("MY FAVORITES")
    end

    expect(page).to have_link("My Favorites")

    within(".dashboard") do
      click_link("My Favorites")
    end

    expect(page).to have_current_path(my_favorites_path)
  end

  scenario "logged in user can save favorites" do
    job = create(:job)
    job.company.update(approve: true)

    user = create(:user)
    user.roles << Role.create(name: "registered_user")

    login_user(user)
    visit company_job_path(job.company, job)

    within("#job-text-box") do
      click_link("SAVE TO FAVORITES")
    end

    within(".flash-notice") do
      expect(page).to have_content("Your Favorites are saved!")
    end

    within(".main-resources") do
      click_on("MY FAVORITES")
    end

    expect(page).to have_current_path(my_favorites_path)
    within(".card-content") do
      expect(page).to have_content(job.title)
    end
  end

  scenario "user cannot save favorites twice" do
    job = create(:job)
    job.company.update(approve: true)

    user = create(:user)
    user.roles << Role.create(name: "registered_user")

    login_user(user)

    visit company_job_path(job.company, job)

    within("#job-text-box") do
      click_link("SAVE TO FAVORITES")
    end

    within(".flash-notice") do
      expect(page).to have_content("Your Favorites are saved!")
    end

    within(".main-resources") do
      click_link("MY FAVORITES")
    end

    expect(page).to have_current_path(my_favorites_path)
    within(".card-content") do
      expect(page).to have_content(job.title)
    end

    within(".card-action") do
      click_link("View opportunity details")
    end
    expect(page).to have_current_path(company_job_path(job.company, job))
    expect(page).to_not contain_exactly("SAVE TO FAVORITES")
    expect(page).to have_content("SAVED")
  end
end
