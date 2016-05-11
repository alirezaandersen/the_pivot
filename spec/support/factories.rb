FactoryGirl.define do

factory :user do
  first_name
  last_name
  email
  password_digest
  role
end

sequence :first_name do |fn|
  "#{fn}"
end

sequence :last_name do |ln|
  "#{ln}"
end

sequence :email do |e|
  "#{e}@gmail.com"
end

sequence :password_digest do |pw|
  "MyPassword#{pw}"
end


sequence :role do |r|
  r = 0
end

end
