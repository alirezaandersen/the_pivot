require 'rails_helper'

RSpec.describe JobsController, :type => :controller do
  context "GET #index" do
    it "assigns jobs as an instance variable" do
      job = create(:job)
      get :index
      expect(assigns(:jobs)).to eq([job])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
