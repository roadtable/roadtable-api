class Session
  include Mongoid::Document
  field :origin, type: String
  field :destination, type: String
  field :api_key, type: String
  field :route, type: Hash
  field :restaurants, type: Hash

  def get_restaurants(coords_array)
    coords_hash = { latitude: coords_array.first, longitude: coords_array.last }
    Yelp.client.search_by_coordinates(coords_hash)
  end


end
