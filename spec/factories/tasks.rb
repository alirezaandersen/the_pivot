FactoryGirl.define do

  factory :task do
    name
    description "MyText"
    date "2016-04-18"
    start_time "2016-04-18 18:58:35"
    hours 1
    volunteer nil
    city nil
    image_path
  end

  sequence :name do |n|
    "#{n} Task"
  end

  sequence :image_path do |n|
    "https://robohash.org/#{n}"
  end

end
