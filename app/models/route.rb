class Route
  include Mongoid::Document
  field :origin, type: String
  field :destination, type: String
  field :session_id, type: Integer
  field :directions, type: Hash
  belongs_to :session_id
  embeds_many :polypoints
  embeds_many :restaurants, store_as: "available_restaurants"
  before_save :get_directions

  def get_directions
    self.directions = HTTParty.get('https://maps.googleapis.com/maps/api/directions/json?origin=' + self.origin + '&destination=' + self.destination, :verify => false)
    polyline = self.directions["routes"].last["overview_polyline"]["points"]
    get_polypoints(polyline)
  end

  def get_polypoints(polyline)
    points = Polylines::Decoder.decode_polyline(polyline)
    (0...points.length).step(5).each do |index|
      @polypoint = Polypoint.find_or_create_by(coordinates: points[index])
      self.polypoints << @polypoint
    end
    get_available_restaurants
  end

  def get_available_restaurants
    self.polypoints.nearby_restaurants.each do |restaurant|
      self.available_restaurants << restaurant
    end
  end

end
