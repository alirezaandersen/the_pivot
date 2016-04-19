# FactoryGirl.define do
#
#   factory :task do
#     name
#     description "MyText"
#     date "2016-04-18"
#     start_time "2016-04-18 18:58:35"
#     hours 1
#     volunteer nil
#     city nil
#     image_path
#     city_id
#   end
#
#   sequence :name do |n|
#     "#{n} Task"
#   end
#
#   sequence :image_path do |n|
#     "https://robohash.org/#{n}"
#   end
#
#   sequence :city_id, ["1", "2", "3"].cycle do |n|
#     "#{n}"
#   end
#
# end
