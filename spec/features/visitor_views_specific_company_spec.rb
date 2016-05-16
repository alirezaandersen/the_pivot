require 'rails_helper'

RSpec.feature "Guest views specific company" do

  scenario "Guest views NIKE's page" do
    company = create(:company)

    visit companies_path

    click_on "#{company.name}"

    expect(current_path).to eq("/companies/#{company.id}")

    expect(page).to have_content(company.name)
    expect(page).to have_xpath("//img[contains(@src, \"#{company.logo}\")]")

    expect(page).to have_content("About Us")
    expect(page).to have_content(company.description)

    expect(page).to have_content("Available Jobs")
  end
end
