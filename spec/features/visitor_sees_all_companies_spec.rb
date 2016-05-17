require "rails_helper"

RSpec.feature "Vistor sees all companies" do
  scenario "visitor clicks on companies" do
    visit root_path
    within("ul.left") do
      click_on "COMPANIES"
    end

    expect(current_path).to eq("/companies")
  end

  scenario "visitor sees a list of companies" do
    nike          = create(:company)
    louis_vuitton = create(:company, name: "Louis Vuitton", logo: "http://luxurylaunches.com/wp-content/uploads/2013/03/louis-vuitton.jpg" )
    spotify       = create(:company, name: "Spotify", logo: "http://thenextweb.com/wp-content/blogs.dir/1/files/2015/07/Screen-Shot-2015-07-20-at-7.48.32-PM.png")

    visit companies_path

    expect(page).to have_content("All Companies")
    expect(page).to have_content(nike.name)
    expect(page).to have_content(louis_vuitton.name)
    expect(page).to have_content(spotify.name)

    expect(page).to have_xpath("//img[contains(@src, \"#{nike.logo}\")]")
    expect(page).to have_xpath("//img[contains(@src, \"#{louis_vuitton.logo}\")]")
    expect(page).to have_xpath("//img[contains(@src, \"#{spotify.logo}\")]")
  end
end
