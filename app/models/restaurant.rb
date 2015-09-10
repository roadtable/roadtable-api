class Restaurant
  include Mongoid::Document
  field :yelp_id, type: String
  field :name, type: String
  field :categories, type: String
  field :mobile_url, type: String
  field :image_url, type: String
  field :rating_img_url, type: String
  field :alert_point, type: Hash
  field :address, type: String
  embedded_in :session
  embedded_in :route
  embedded_in :polypoint

  # Turn array of categories into a string
  def self.categories_to_string(array)
    array.collect! { |item| item[0] }.join(", ")
  end

  def self.address_to_string(address)
    address.join(" ")
  end

end
