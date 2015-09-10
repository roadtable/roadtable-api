class Restaurant
  include Mongoid::Document
  field :yelp_id, type: String
  field :name, type: String
  field :categories, type: String
  field :mobile_url, type: String
  field :image_url, type: String
  field :rating_img_url, type: String
  field :polypoint, type: Hash
  embedded_in :session
  embedded_in :route
  embedded_in :polypoint

  before_save :categories_to_string

  # Turn array of categories into a string
  def categories_to_string
    self.categories.collect! { |item| item[0] }.join(", ")
  end

end
