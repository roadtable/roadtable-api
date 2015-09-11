require 'rails_helper'

RSpec.describe RoutesController, type: :controller do
  describe "GET /routes" do
    it 'it returns an available_restaurants array' do
      Session.all.destroy_all
      post :create, { controller: "sessions", origin: "Indianapolis", destination: "Chicago", api_key: "1" }
      expect(response).to be_success
      expect(Session.all.count).to eq(1)
      get :show, {api_key: "1"}
      expect_json_types(:array)
    end
  end


end
