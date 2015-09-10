class Session
  include Mongoid::Document
  field :api_key, type: String
  has_one :route
  embeds_many :restaurants, as: :chosen_restaurants


  ####
  #
  # MOVING TO POLYPOINT
  #
  ####
  # Gets five restaurants near every nth poly point
  # Converts data to hash
  # def get_restaurants(points)
  #   i = 0
  #   increment = 10
  #   while i < points.length
  #     # Convert point array into hash
  #     point_hash = { latitude: points[i].first, longitude: points[i].last }
  #
  #     # Returns BurstStruct object that Yelp creates
  #     point_results = Yelp.client.search_by_coordinates(point_hash, { limit: 5 })
  #
  #     # Reformat that Yelp object into hash with only the data we need
  #     point_results.businesses.each do |restaurant|
  #       self.restaurants << {
  #         id: restaurant.id,
  #         name: restaurant.name,
  #         rating: restaurant.rating,
  #         display_phone: restaurant.respond_to?(:display_phone) ? restaurant.phone : "",
  #         categories: restaurant.respond_to?(:categories) ? categories_to_string(restaurant.categories) : "",
  #         mobile_url: restaurant.respond_to?(:mobile_url) ? restaurant.mobile_url : "",
  #         rating_img_url: restaurant.respond_to?(:rating_img_url) ? restaurant.rating_img_url : "",
  #         image_url: restaurant.respond_to?(:image_url) ? restaurant.image_url : "http://s3-media4.fl.yelpcdn.com/assets/srv0/yelp_styleguide/c73d296de521/assets/img/default_avatars/business_90_square.png",
  #         display_address: restaurant.respond_to?(:display_address) ? restaurant.display_address : "",
  #         polypoint: { latitude: points[i].first, longitude: points[i].last }
  #       }
  #     end
  #     i += increment
  #   end
  # end

  # TO RESTAURANT
  # def categories_to_string(array)
  #   single_categories = array.collect do |item|
  #     item[0]
  #   end
  #   single_categories.join(", ")
  # end

  # TO ROUTE
  # def remove_duplicate_restaurants
  #   self.restaurants.uniq!{ |restaurant| restaurant[:id] }
  # end

end
