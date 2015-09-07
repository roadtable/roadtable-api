class SessionsController < ApplicationController

  def index
  end

  def show
    if params[:api_key]
      render json: Session.where(:api_key => params[:api_key])
    else
      render json: "An api key is needed for this request."
    end
  end

  def create
    #Only execute if an api_key is passed
    if params[:api_key]
      @session = Session.new(session_params)
      @session.api_key = params[:api_key]
      @session.route = HTTParty.get('https://maps.googleapis.com/maps/api/directions/json?origin=' + @session.origin + '&destination=' + @session.destination, :verify => false)

      # Finds polyline string in route json
      polyline = @session.route["routes"].last["overview_polyline"]["points"]

      # Creates an array of polypoint arrays [lat,long]
      polypoints = Polylines::Decoder.decode_polyline(polyline)

      @session.get_restaurants(polypoints)
    else
      render json: "An api key is needed for this request."
    end

    if @session.save
      render json: @session
    else
      render json: "The origin/destination is invalid."
    end
  end

  def add_to_list
    if params[:api_key]
      @session = Session.where(:api_key => params[:api_key])
      restaurant = @session.detect{|restaurant| restaurant["id"] = params[:id]}
      @session.restaurants << restaurant
      @session.save!
    else
      render json: "An api key is needed for this request."
    end
  end

  def test
    render json: Session.all[0]
  end

  private

  def session_params
    params.permit(:origin, :destination, :api_key)
  end

end
