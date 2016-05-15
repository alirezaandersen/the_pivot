class Submission < ActiveRecord::Base

enum approval:["pending", "approved", "denied"]

end
