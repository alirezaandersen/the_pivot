FactoryGirl.define do
  factory :task do
    sequence :name
    description "MyText"
    date "2016-04-18"
    start_time "2016-04-18 18:58:35"
    hours 1
    volunteer nil
    city nil
  end

  sequence :name do |n|
    "#{n} Task"
  end

end
