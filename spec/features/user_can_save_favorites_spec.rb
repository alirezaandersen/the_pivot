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
    expect(page).to have_current_path("/favorites")
    expect(page).to_not contain_exactly("Save your Favorites")
    click_button("Login to save your Favorites")
  end

  scenario "guest user must login to save favorites" do
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

    within(".card-content") do
      expect(page).to have_content(job.title)
      expect(page).to have_content(job.company.name)
    end
  end

  scenario "guest user must register to save favorites" do
    job = create(:job)
    job.company.update(approve: true)

    user = create(:user)
    Role.create(name: "registered_user")

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

    click_link "REGISTER"

    expect(page).to have_current_path new_user_path

    expect(page).to have_content("Create Account")

    fill_in "First Name", with: "ali"
    fill_in "Last Name", with: "andersen"
    fill_in "Email", with: "ali@ali.com"
    fill_in "Password", with: "ali"
    fill_in "Confirm Password", with: "ali"

    click_on "CREATE ACCOUNT"

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

    within(".card-content") do
      expect(page).to have_content(job.title)
      expect(page).to have_content(job.company.name)
    end
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
      expect(page).to have_content(job.company.name)
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
      expect(page).to have_content(job.company.name)
    end

    within(".card-action") do
      click_link("View opportunity details")
    end
    expect(page).to have_current_path(company_job_path(job.company, job))
    expect(page).to_not contain_exactly("SAVE TO FAVORITES")
    expect(page).to have_link("REMOVE FAVORITE")
  end

  scenario "logged in user can remove job from saved favorites" do
    job = create(:job)
    job.company.update(approve: true)

    user = create(:user)
    user.roles << Role.create(name: "registered_user")
    users_job = UsersJob.create(user_id: user.id, job_id: job.id)

    login_user(user)

    within(".main-resources") do
      click_link("MY FAVORITES")
    end

    expect(page).to have_current_path(my_favorites_path)

    within(".card-content") do
      expect(page).to have_content(job.title)
      expect(page).to have_content(job.company.name)
    end

    within(".card-action") do
      click_link("View opportunity details")
    end
    expect(page).to have_current_path(company_job_path(job.company, job))

    expect(page).to_not contain_exactly("SAVE TO FAVORITES")
    expect(page).to have_content("REMOVE FAVORITE")

    click_link("REMOVE FAVORITE")

    expect(page).to have_current_path(my_favorites_path)

    expect(page).to_not have_content(job.title)
    expect(page).to_not have_content(job.company.name)
  end
end
