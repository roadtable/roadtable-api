class Session
  include Mongoid::Document
  field :origin, type: String
  field :destination, type: String
  field :api_key, type: String
  field :route, type: Hash
  field :restaurants, type: Hash

  
end
