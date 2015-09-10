class Restaurant
  include Mongoid::Document
  field :yelp_id, type: String
  field :name, type: String
  field :categories, type: String
  field :mobile_url, type: String
  field :image_url, type: String
  field :rating_img_url, type: String
  field :polypoint, type: Hash
  embeds_in :session
  embeds_in :route
  embeds_in :polypoint
end
