require 'rails_helper'


RSpec.feature "Store Admin can view all other store admin within their store" do
  scenario "Store Admin views peers within their store" do

    user = store_admin_user
    company = create(:company)
    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path store_admin_dashboard_path

    click_link("View Store Admins")

    expect(page).to have_current_path view_store_admins_path(user.id)
    expect(page).to have_content("Company #{company.name}")
    expect(page).to have_content("Administration")
  end
end
