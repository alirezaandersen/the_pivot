require 'rails_helper'

RSpec.describe JobPresenter do
  include ActionView::TestCase::Behavior

  before :each do
    @job_presenter = JObPresenter.new
  end
end
