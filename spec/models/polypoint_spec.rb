require 'rails_helper'

RSpec.describe Polypoint, type: :model do
  it 'saves with five restaurants' do
    polypoint = Polypoint.create(coordinates: [40.075558, -83.095400])
    expect(polypoint.nearby_restaurants.count).to eq(5)
  end
end
