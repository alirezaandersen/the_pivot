require 'rails_helper'

RSpec.describe Job, type: :model do
  context 'associations' do
    it { should have_many(:users_jobs) }
    it { should have_many(:users).through(:users_jobs) }
    it { should belong_to(:city) }
    it { should belong_to(:company) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
