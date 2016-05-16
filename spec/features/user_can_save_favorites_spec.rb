require 'rails_helper'

RSpec.feature "Registered user can save favorites" do
  include UserHelpers

  scenario "guest user cannot save favorites" do
    job = create(:job)

    visit job_path(job)

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

  scenario "guest user must login or register to save favorites" do
    user = create(:user)
    job = create(:job)

    visit job_path(job)

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
    within(".main-resources") do
      expect(page).to have_content("LOGOUT")
    end

    expect(page).to have_current_path("/dashboard")
    expect(page).to have_link("My Favorites")

    within(".dashboard") do
      click_on("My Favorites")
    end
    # save_and_open_page
    expect(page).to have_current_path(my_favorites_path)

    within(".card-reveal") do
      expect(page).to have_content(job.title)
    end
  end

  scenario "logged in user can save favorites" do
    user = create(:user)
    job = create(:job)

    login_user(user)

    visit job_path(job)

    within("#job-text-box") do
      click_link("FAVORITE")
    end

    within(".main-resources") do
      click_on("FAVORITES")
    end

    expect(page).to have_current_path("/favorites")
    expect(page).to have_button("Save your Favorites")
    click_button("Save your Favorites")

    expect(page).to have_current_path(my_favorites_path)
    within(".flash-notice") do
      expect(page).to have_content("Your Favorites are saved!")
    end

    within(".card-reveal") do
      expect(page).to have_content(job.title)
    end

    within(".main-resources") do
      click_on("FAVORITES")
    end

    expect(page).to have_current_path("/favorites")

    expect(page).to have_content("No Favorites!")
    expect(page).to_not have_content(job.title)
  end
end
