require 'rails_helper'

RSpec.feature "All visitors can see about us page" do
  scenario "Any user or admin can see about page" do

    visit root_path

    within("footer") do
        click_link "About Us"
    end

    expect(page).to have_current_path about_us_path
    expect(page).to have_content("ABOUT US ")
    expect(page).to have_content("Ziba the Utopia of jobs")
  end
end
