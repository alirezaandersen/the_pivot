require "rails_helper"

RSpec.feature "Companies that are not hiring" do
  scenario "No Jobs Available" do
    nike = create(:company)

    visit company_path(nike)

    expect(page).to have_content("no jobs available")
  end
end
