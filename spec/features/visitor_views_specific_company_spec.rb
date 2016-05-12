require 'rails_helper'

RSpec.feature "Guest views specific company" do
  scenario "Guest views NIKE's page" do
    nike = create(:company)
    shoe_maker = create(:job, title: "shoe maker", company_id: nike.id)

    visit companies_path

    click_on "NIKE"

    expect(current_path).to eq("/companies/#{nike.id}")

    expect(page).to have_content(nike.name)
    expect(page).to have_xpath("//img[contains(@src, \"#{nike.logo}\")]")

    expect(page).to have_content("About Us")
    expect(page).to have_content(nike.description)

    expect(page).to have_content("Available Positions")
    expect(page).to have_content(shoe_maker.title)
    expect(page).to have_content(shoe_maker.description)
    expect(page).to have_content(shoe_maker.city.name)
    expect(page).to have_content(shoe_maker.city.state)
  end
end
