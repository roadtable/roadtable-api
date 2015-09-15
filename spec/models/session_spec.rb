require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'saves api_key' do
    Session.destroy_all
    api_key = "29308457"
    session = Session.create(api_key: api_key)
    expect(session.api_key).to eq(api_key)
    expect(session).to validate_presence_of(:api_key)
  end

  it 'does not save without api key' do
    Session.destroy_all
    session = Session.create
    expect(session).to be_invalid
  end

  it 'can have a route' do
    Session.destroy_all
    session = Session.create(api_key: "923874")
    session.route = Route.create(origin: "Portland", destination: "Seattle")
    expect(session.route.class).to eq(Route)
  end

  it 'can embed restaurants' do
    Session.destroy_all
    session = Session.create(api_key: "90238475")
    session.route = Route.create(origin: "Portland", destination: "Seattle")
    restaurant = session.route.polypoints.first.nearby_restaurants.first
    session.chosen_restaurants << restaurant
    expect(session.chosen_restaurants.count).to eq(1)
  end
end
