module UserHelpers
#   def create_and_login_admin
#     admin = Volunteer.create(first_name: "John",
#                              last_name: "Last",
#                              username: "admin",
#                              email: "admin@me.com",
#                              password: "password",
#                              role: 1)
#     login_volunteer(admin)
#   end
#
  def login_user(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")
  end
#
#   def cart_checkout
#     visit tasks_path
#     page.all(".card-action")[0].click_link("Add to Cart")
#     page.all(".card-action")[1].click_link("Add to Cart")
#
#     within(".main-resources") do
#       click_on("Cart: 2")
#     end
#
#     click_on("Checkout")
#   end
#
#   def temp_helper
#     volunteer = create(:volunteer)
#     tasks = create_list(:task, 2)
#     volunteer.tasks << tasks
#     volunteer
#   end
end
