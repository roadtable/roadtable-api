class Session
  include Mongoid::Document
  field :origin, type: String
  field :destination, type: String
  field :api_key, type: String
  field :route, type: Hash
  field :restaurants, type: Hash, default: {}

  # def get_restaurants(points)
  #   points.each do |point_array|
  #     # Convert point array to hash
  #     point_hash = { latitude: point_array.first, longitude: point_array.last }
  #     point_results = Yelp.client.search_by_coordinates(point_hash)
  #     self.restaurants += point_results.businesses
  #   end
  # end

  def get_restaurants(points)
    i = 0
    while i < points.length
      # Convert point array into hash
      point_hash = { latitude: points[i].first, longitude: points[i].last }
      point_results = Yelp.client.search_by_coordinates(point_hash, { limit: 5 })
      point_results.businesses.each do |restaurant|
        self.restaurants[restaurant.name] = {
          rating: restaurant.rating,
          display_phone: restaurant.respond_to?(:display_phone) ? restaurant.phone : "",
          categories: restaurant.respond_to?(:categories) ? restaurant.categories : [],
          mobile_url: restaurant.respond_to?(:mobile_url) ? restaurant.mobile_url : "",
          rating_img_url: restaurant.respond_to?(:rating_img_url) ? restaurant.rating_img_url : "",
          image_url: restaurant.respond_to?(:image_url) ? restaurant.image_url : "",
          display_address: restaurant.respond_to?(:display_address) ? restaurant.display_address : "",
        }
      end
      i += 10
    end
  end


end
