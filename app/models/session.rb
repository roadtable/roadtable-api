class Session
  include Mongoid::Document
  field :api_key, type: String
  has_one :route
  embeds_many :restaurants
end
