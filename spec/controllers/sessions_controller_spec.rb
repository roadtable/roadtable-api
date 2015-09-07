require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST /sessions" do
    it 'sends a successful POST request' do

      post :create, {origin: "Indianapolis", destination: "Chicago", api_key: "string"}

      expect(response).to be_success

    end
  end

end
