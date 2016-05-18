require 'rails_helper'

RSpec.feature "Guest views specific company" do
  scenario "Guest views NIKE's page" do
    company = create(:company)
    company.update(approve: true)
    shoe_maker = create(:job, title: "shoe maker", company_id: company.id)

    visit companies_path

    within(page.all(".card-action")[0]) do
      click_link "#{company.name}"
    end

    expect(current_path).to eq("/companies/#{company.slug}")

    expect(page).to have_content(company.name)
    expect(page).to have_xpath("//img[contains(@src, \"#{company.logo}\")]")

    expect(page).to have_content("About Us")
    expect(page).to have_content(company.description)

    expect(page).to have_content("Available Positions")
    expect(page).to have_content(shoe_maker.title)
    expect(page).to have_content(shoe_maker.description)
  end
end
