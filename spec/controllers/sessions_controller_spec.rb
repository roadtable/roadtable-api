require 'rails_helper'

##
# Make sure your local server is running
###

RSpec.describe SessionsController, type: :controller do
  describe "POST /sessions" do
    it 'sends a successful POST request' do
      Session.all.destroy_all
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      expect(response).to be_success
      expect(Session.all.count).to eq(1)
    end
    it 'does not create a session object without an api_key' do
      Session.all.destroy_all
      post :create, { origin: "Indianapolis", destination: "Chicago" }
      expect(Session.all.count).to eq(0)
    end
  end

  describe "GET /sessions" do
    it 'gives a json response containing chosen restaurant array' do
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      get :show, { api_key: "1" }
      expect_json_types(:array)
    end
  end

  describe "UPDATE /sessions" do
    it 'adds new restaurants to chosen restaurants' do
      Session.all.destroy_all
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      session = Session.last
      post :update, { api_key: "1", action: "add", yelp_id: "#{session.route.polypoints.first.nearby_restaurants.first.yelp_id}" }
      get :show, { api_key: "1" }
      expect_json_sizes(chosen_restaurants: 1)
    end
  end



end
