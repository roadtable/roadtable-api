class Polypoint
  include Mongoid::Document

  #Database columns
  field :coordinates, type: Array

  #Embedded documents
  embeds_many :restaurants
  alias :nearby_restaurants :restaurants

  #Relations
  belongs_to :route

  #Callbacks
  before_save :get_nearby_restaurants

  def get_nearby_restaurants
    point = self.coordinates
    point_hash = { latitude: point.first, longitude: point.last }
    # Returns BurstStruct object that Yelp creates
    point_results = Yelp.client.search_by_coordinates(point_hash, { limit: 5 })
    point_results.businesses.each do |restaurant|
        @restaurant = Restaurant.new(
        yelp_id: restaurant.id,
        name: restaurant.name,
        categories: restaurant.respond_to?(:categories) ? Restaurant.categories_to_string(restaurant.categories) : "",
        mobile_url: restaurant.respond_to?(:mobile_url) ? restaurant.mobile_url : "",
        rating_img_url: restaurant.respond_to?(:rating_img_url) ? restaurant.rating_img_url : "",
        image_url: restaurant.respond_to?(:image_url) ? restaurant.image_url : "http://s3-media4.fl.yelpcdn.com/assets/srv0/yelp_styleguide/c73d296de521/assets/img/default_avatars/business_90_square.png",
        address: restaurant.respond_to?(:location) ? Restaurant.address_to_string(restaurant.location.display_address) : "",
        alert_point: { latitude: point.first, longitude: point.last }
        )
        self.restaurants << @restaurant
    end
  end

end
