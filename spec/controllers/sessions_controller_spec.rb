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
  describe "POST /add_to_list" do
    it 'adds a restaurant to a sessions list' do
      Session.all.destroy_all
      expect(Session.all.count).to eq(0)
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      post :add_to_list, {id: "three-carrots-indianapolis-2", api_key: "1"}
      expect(response).to be_success
      expect(Session.last.list.count).to eq(1)
    end
  end

  describe "POST /remove_from_list" do
    it 'removes a restaurant from a sessions list' do
      Session.all.destroy_all
      expect(Session.all.count).to eq(0)
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      post :add_to_list, {id: "three-carrots-indianapolis-2", api_key: "1"}
      expect(response).to be_success
      expect(Session.last.list.count).to eq(1)
      post :remove_from_list, {id: "three-carrots-indianapolis-2", api_key: "1"}
      expect(response).to be_success
      expect(Session.last.list.count).to eq(0)
    end
  end

  describe "GET / view_list" do
    it 'returns a list array' do
      Session.all.destroy_all
      expect(Session.all.count).to eq(0)
      post :create, { origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      post :add_to_list, {id: "three-carrots-indianapolis-2", api_key: "1"}
      expect(response).to be_success
      expect(Session.last.list.count).to eq(1)
      get :view_list, {api_key: "1"}
      expect_json_types(list: :array)
      expect(response).to be_success
    end
  end

end
