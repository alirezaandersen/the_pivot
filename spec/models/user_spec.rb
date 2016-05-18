require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:contact_us) }
    it { should have_many(:users_jobs) }
    it { should have_many(:user_roles) }
    it { should have_many(:jobs).through(:users_jobs) }
    it { should have_many(:roles).through(:user_roles) }
    it { should belong_to(:company) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    # format of email
  end

  context "user helper methods" do
    it "returns true if user is platform admin" do
      user1, user2, user3 = create_list(:user, 3)
      user1.roles << Role.create(name: "platform_admin")
      user2.roles << Role.create(name: "store_admin")
      user3.roles << Role.create(name: "registered_user")

      expect(user1.platform_admin?).to eql(true)
      expect(user2.platform_admin?).to eql(false)
      expect(user3.platform_admin?).to eql(false)
    end

    it "returns true if user is store admin" do
      user1, user2, user3 = create_list(:user, 3)
      user1.roles << Role.create(name: "platform_admin")
      user2.roles << Role.create(name: "store_admin")
      user3.roles << Role.create(name: "registered_user")

      expect(user1.store_admin?).to eql(false)
      expect(user2.store_admin?).to eql(true)
      expect(user3.store_admin?).to eql(false)
    end

    it "returns true if user is registered_user" do
      user1, user2, user3 = create_list(:user, 3)
      user1.roles << Role.create(name: "platform_admin")
      user2.roles << Role.create(name: "store_admin")
      user3.roles << Role.create(name: "registered_user")

      expect(user1.registered_user?).to eql(false)
      expect(user2.registered_user?).to eql(false)
      expect(user3.registered_user?).to eql(true)
    end
  end

  context "#add_company" do
    it "adds company_id to current_user" do
      user = create(:user)
      Role.create(name: "registered_user")
      company = create(:company)

      expect(user.company_id).to eql(nil)

      user.add_company(company)

      expect(user.company_id).to eql(company.id)
    end
  end

  context "#store_admin!" do
    it "adds role store_admin to newly created user in user_roles table" do
      user = create(:user)
      Role.create(name: "store_admin")

      expect(user.roles.last).to eql(nil)

      user.store_admin!

      expect(user.roles.last.name).to eql("store_admin")
    end
  end

  context "#add_registered_user_role" do
    it "adds role registered_user to newly created user in user_roles table" do
      user = create(:user)
      Role.create(name: "registered_user")

      expect(user.roles.last).to eql(nil)

      user.add_registered_user_role

      expect(user.roles.last.name).to eql("registered_user")
    end
  end

  context "#add_store_admin_role" do
    it "adds role store_admin to newly created user in user_roles table" do
      user = create(:user)
      Role.create(name: "store_admin")

      expect(user.roles.last).to eql(nil)

      user.add_store_admin_role

      expect(user.roles.last.name).to eql("store_admin")
    end
  end

  context "#company_users" do
    it "finds store_admins for company" do
      user1, user2, user3 = create_list(:user, 3)
      company = create(:company)

      user1.add_company(company)
      user3.add_company(company)

      company_admins = User.company_users(company.id)

      expect(company_admins).to include(user1)
      expect(company_admins).to include(user3)
      expect(company_admins).to_not include(user2)
    end
  end
end
