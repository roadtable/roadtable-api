require 'rails_helper'

##
# Make sure your local server is running
###

RSpec.describe SessionsController, type: :controller do
  describe "POST /sessions" do
    it 'sends a successful POST request' do
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      expect(response).to be_success
    end
  end

  describe "GET /sessions" do
    it 'GET request returns a session object' do
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      get :show, { api_key: "1" }
      expect_json(origin: "Indianapolis")
      expect(response).to be_success
    end
  end

end
