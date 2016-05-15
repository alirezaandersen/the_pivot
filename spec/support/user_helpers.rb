module UserHelpers
  def create_user
    user = User.create(first_name: "John",
                       last_name: "Last",
                       email: "user@me.com",
                       password: "password",
                       role: 0)
    login_user(user)
  end

  def login_user(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within('.login-signup') do
      click_on("LOGIN")
    end
  end
#
  def users_job_with_resume(user, job)
    UsersJob.create(user_id: user.id, job_id: job.id, resume: "#{Rails.root}/spec/support/sample_cv_of_failures.pdf", status: 1)
  end
end
