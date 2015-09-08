class Session
  include Mongoid::Document
  field :origin, type: String
  field :destination, type: String
  field :api_key, type: String
  field :route, type: Hash
  field :restaurants, type: Array, default: []
  field :list, type: Array, default: []

  # Gets five restaurants near every nth poly point
  # Converts data to hash
  def get_restaurants(points)
    i = 0
    increment = 10
    while i < points.length
      # Convert point array into hash
      point_hash = { latitude: points[i].first, longitude: points[i].last }

      # Returns BurstStruct object that Yelp creates
      point_results = Yelp.client.search_by_coordinates(point_hash, { limit: 5 })

      # Reformat that Yelp object into hash with only the data we need
      point_results.businesses.each do |restaurant|
        self.restaurants << {
          id: restaurant.id,
          name: restaurant.name,
          rating: restaurant.rating,
          display_phone: restaurant.respond_to?(:display_phone) ? restaurant.phone : "",
          categories: restaurant.respond_to?(:categories) ? categories_to_string(restaurant.categories) : "",
          mobile_url: restaurant.respond_to?(:mobile_url) ? restaurant.mobile_url : "",
          rating_img_url: restaurant.respond_to?(:rating_img_url) ? restaurant.rating_img_url : "",
          image_url: restaurant.respond_to?(:image_url) ? restaurant.image_url : "",
          display_address: restaurant.respond_to?(:display_address) ? restaurant.display_address : "",
          polypoint: { latitude: points[i].first, longitude: points[i].last }
        }
      end
      i += increment
    end
    self.restaurants.uniq! { |restaurant| restaurant["id"] }
  end

  def categories_to_string(array)
    single_categories = array.collect do |item|
      item[0]
    end
    single_categories.join(", ")
  end

end
