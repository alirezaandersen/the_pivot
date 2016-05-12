class UsersJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :job

  # enum status %w(favorited, applied)
  # status update
  # favorite!
  # applied!
end
