require 'rails_helper'


RSpec.feature "Platform Admin can create job current company clients" do
  scenario "Platform Admin can see companies which are active" do

    user = platform_admin_user
    company = create(:company)
    company.update(approve: true)
    city = create(:city)

    visit login_path

    expect(page).to have_current_path login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "LOGIN"

    expect(page).to have_current_path platform_admin_dashboard_path

    click_link("Available Companies")

    expect(page).to have_current_path active_companies_path

    expect(page).to have_content("Active Companies")
    expect(page).to have_content("Total Active Companies")

    click_on "CREATE JOB"

    expect(page).to have_current_path create_company_jobs_path(company.id)

    fill_in "Position Title", with: "Teacher"
    fill_in "Department", with: "Education"
    fill_in "Requirements", with: "Smiles"
    fill_in "Job Type", with: "Full Time"
    fill_in "Salary", with: "1000"
    fill_in "Description of Job", with: "Programmer"

    click_on "Create A Job"
    job = Job.find_by(company_id: company.id, title: "Teacher")
    # job = job.update(city_id: city.id)

    expect(page).to have_current_path company_job_path(company, job)
    expect(page).to have_content("Teacher at #{company.name}")
  end
end
