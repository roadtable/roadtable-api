class Route
  include Mongoid::Document
  field :origin, type: String
  field :destination, type: String
  field :session_id, type: Integer
  field :directions, type: Hash
  belongs_to :session
  has_and_belongs_to_many :polypoints, inverse_of: nil
  embeds_many :restaurants, as: :available_restaurants
  before_save :get_directions

  def get_directions
    self.directions = HTTParty.get('https://maps.googleapis.com/maps/api/directions/json?origin=' + self.origin + '&destination=' + self.destination, :verify => false)
    polyline = self.directions["routes"].last["overview_polyline"]["points"]
    get_polypoints(polyline)
  end

  def get_polypoints(polyline)

    points_array = Polylines::Decoder.decode_polyline(polyline)
    (0...points_array.length).step(5).each do |index|
      @polypoint = Polypoint.find_or_initialize_by(coordinates: points_array[index])
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
