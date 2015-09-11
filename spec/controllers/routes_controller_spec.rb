require 'rails_helper'

RSpec.describe RoutesController, type: :controller do
  describe "GET /routes" do
    it 'it returns an available_restaurants array' do
      @session = Session.create(api_key: "1")
      @route = Route.create(origin: "Indianapolis", destination: "Bloomington", session_id: @session.id)
      get :show, {api_key: "1"}
      expect_json_types(:array)
    end
  end


end
