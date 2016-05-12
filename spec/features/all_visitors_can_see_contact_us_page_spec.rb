require 'rails_helper'

RSpec.feature "All visitors can see about us page" do
  scenario "Any user or admin can see about page" do

    visit root_path

    within("footer") do
        click_link "Contact Us"
    end

    expect(page).to have_current_path contact_us_path
    expect(page).to have_content("We would love to hear from you")
    expect(page).to have_css('input[type="text"]')
   end
end
