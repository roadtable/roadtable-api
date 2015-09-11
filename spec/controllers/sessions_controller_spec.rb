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
    it 'adds restaurant to chosen restaurants' do
      session = Session.create(api_key: "1")
      session.route = Route.create(origin: "Indianapolis", destination: "Chicago", session_id: session.id)
      restaurant = session.route.available_restaurants.first
      patch :update, { api_key: "1", akushon: "add", yelp_id: restaurant.yelp_id }

      expect(session.chosen_restaurants.first).to eq(restaurant)
      expect(session.chosen_restaurants.count).to eq(1)
    end

    it 'removes restaurant from chosen restaurants' do
      session = Session.create(api_key: "1")
      session.route = Route.create(origin: "Indianapolis", destination: "Chicago", session_id: session.id)
      restaurant = session.route.available_restaurants.first
      session.chosen_restaurants.batch_insert([restaurant])
      # Delete the restaurant
      patch :update, { api_key: "1", akushon: "delete", yelp_id: restaurant.yelp_id }
      expect(session.chosen_restaurants.count).to eq(0)
    end
  end



end
