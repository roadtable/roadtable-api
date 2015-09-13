require 'rails_helper'

RSpec.describe Route, type: :model do
  it 'does not create a route without an origin' do
    Route.all.destroy_all
    route = Route.create(:destination => "Seattle")
    expect(route).to be_invalid
    expect(route).to validate_presence_of(:origin)
  end
  it 'does not create a route without a destination' do
    Route.all.destroy_all
    route = Route.create(:origin => "Seattle")
    expect(route).to be_invalid
    expect(route).to validate_presence_of(:destination)
  end
  it 'adds directions, polypoints, and restaurants to a route before saving' do
    Route.all.destroy_all
    route = Route.create(:origin => "Indianapolis", :destination => "Bloomington")
    expect(route).to respond_to(:directions)
    expect(route).to respond_to(:polypoints)
    expect(route).to respond_to(:available_restaurants)
  end
  it 'adds unique restaurants to available_restaurants' do
    Route.all.destroy_all
    route = Route.create(:origin => "Bloomington, IN", :destination => "Columbus, IN")
    expect(route.available_restaurants.where(yelp_id: "turkuaz-cafe-bloomington").count). to eq(1)
    expect(route.available_restaurants.uniq!).to eq(nil)
  end
end
