require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'associations' do
    it { should have_many(:user_roles) }
    it { should have_many(:users).through(:user_roles) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
