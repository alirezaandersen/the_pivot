class Submission < ActiveRecord::Base

  validates :email, presence: true,
    uniqueness: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  enum approval:["pending", "approved", "denied"]

end
