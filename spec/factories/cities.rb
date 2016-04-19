# FactoryGirl.define do
#
#   factory :city do
#     name "City"
#     state "SA"
#   end
#
#   sequence :name, ["A", "B", "C"].cycle do |n|
#     "City #{n}"
#   end
#
#   sequence :state, ["X", "Y", "Z"].cycle do |n|
#     "#{n}#{n}"
#   end
#
# end
