class SessionsController < ApplicationController

  def index
  end

  def show
    if params[:api_key]
      render json: Session.where(:api_key => params[:api_key]).first
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
      @session.remove_duplicate_restaurants

      if @session.save
        render json: @session
      else
        render json: "The origin/destination is invalid."
      end
      
    else
      render json: "An api key is needed for this request."
    end

  end

  def add_to_list
    if params[:api_key]
      @session = Session.where(:api_key => params[:api_key]).first
      restaurant = @session.restaurants.detect{|restaurant| restaurant["id"] == params[:id]}
      @session.list << restaurant
      @session.save!
    else
      render json: "An api key is needed for this request."
    end
  end

  def remove_from_list
    if params[:api_key]
      @session = Session.where(:api_key => params[:api_key]).first
      restaurant = @session.list.detect{|restaurant| restaurant["id"] == params[:id]}
      @session.list.delete(restaurant)
      @session.save!
    else
      render json: "An api key is needed for this rddsequest."
    end
  end

  def view_list
    if params[:api_key]
      render json: Session.where(:api_key => params[:api_key]).first
    else
      render json: "An api key is needed for this request."
    end
  end

  private

  def session_params
    params.permit(:origin, :destination, :api_key)
  end

end
