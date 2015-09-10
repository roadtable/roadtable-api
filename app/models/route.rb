class Route
  include Mongoid::Document
  field :origin, type: String
  field :destination, type: String
  field :session_id, type: Integer
  field :directions, type: Hash
  belongs_to :session
  embeds_many :polypoints
  embeds_many :restaurants
  before_save :get_directions

  def get_directions
    puts "Hey from Route!"
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
    self.polypoints.each do |polypoint|
      self.restaurants += polypoint.restaurants
    end
  end

end
