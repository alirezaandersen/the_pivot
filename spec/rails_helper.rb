
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'database_cleaner'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

    config.include FactoryGirl::Syntax::Methods
    config.include UserHelpers

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    config.around(:each) do |example|
      DatabaseCleaner.cleaning do
        example.run
      end
    end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  def store_admin_user
    user = create(:user)
    Role.create(name: "store_admin")
    user.roles << Role.find_by(name: "store_admin")
    user.update(company_id: 1)
    user
  end

  def platform_admin_user
    user = create(:user)
    Role.create(name: "platform_admin")
    user.roles << Role.find_by(name: "platform_admin")
    user.update(company_id: 1)
    user
  end
end
