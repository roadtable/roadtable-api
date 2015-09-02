class SessionsController < ApplicationController

  def index
  end

  def show
  end

  def create
    @session = Session.new(session_params)
    @session.route = HTTParty.get('https://maps.googleapis.com/maps/api/directions/json?origin=' + @session.origin + '&destination=' + @session.destination)

    # Finds polyline string in route json
    polyline = @session.route["routes"].last["overview_polyline"]["points"]

    # Creates an array of polypoint arrays [lat,long]
    polypoints = Polylines::Decoder.decode_polyline(polyline)

    @session.get_restaurants(polypoints)

    if @session.save
      render json: @session
    else
      render json: "The origin/destination is invalid."
    end
  end

  def test
    render json: Session.all[-1]
  end

  private

  def session_params
    params.permit(:origin, :destination)
  end

end
