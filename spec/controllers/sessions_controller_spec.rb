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
    it 'gives a json response containing restaurant array' do
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      expect_json_types(restaurants: :array)
    end
    it 'does not create a session object without an api_key' do
      Session.all.destroy_all
      post :create, { origin: "Indianapolis", destination: "Chicago" }
      expect(Session.all.count).to eq(0)
    end
  end

  describe "GET /sessions" do
    it 'returns a session object' do
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      get :show, { api_key: "1" }
      expect_json(origin: "Indianapolis")
      expect(response).to be_success
    end
    it 'gives a json response containing restaurant array' do
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      get :show, { api_key: "1" }
      expect_json_types(restaurants: :array)
    end
  end

end
