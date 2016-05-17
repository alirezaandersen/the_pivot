require 'rails_helper'


RSpec.feature "Store Admin Can log in" do
  scenario "Store Admin can log in and see their dashboard" do

    user = store_admin_user
    company = create(:company)
    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path store_admin_dashboard_path
    expect(page).to have_link("Update Company Information")

    click_link "Update Company Information"

    expect(page).to have_current_path update_company_path(user.company_id)

    fill_in "Company Name", with: "Holmz"
    fill_in "Company Logo", with: "Jue"
    fill_in "Company url", with: "No Picture Available"
    fill_in "Company Size", with: "100-4311"
    fill_in "Company Industry", with: "Dog Bouncer"
    fill_in "Company Description", with: "Woof woof"
    # binding.pry
    click_on "Submit Application"

    expect(page).to have_current_path company_path(company.id)
    expect(page).to have_content("Holmz has been updated")
  end
end
