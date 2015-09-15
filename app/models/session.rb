class Session
  include Mongoid::Document
  #Database columns
  field :api_key, type: String
  #Embedded documents
  embeds_many :restaurants
  alias :chosen_restaurants :restaurants
  #Relations
  has_one :route
  #Validations
  validates_presence_of :api_key

end
