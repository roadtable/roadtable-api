class Session
  include Mongoid::Document
  include MongoidExtendedDirtyTrackable
  field :api_key, type: String
  has_one :route
  embeds_many :restaurants
  alias_method :chosen_restaurants, :restaurants
end
