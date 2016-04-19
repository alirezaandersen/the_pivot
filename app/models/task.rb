class Task < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :city
end
