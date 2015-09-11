class SessionsController < ApplicationController
  skip_before_action :set_session, only: :create

  def show
    render json: @session.chosen_restaurants
  end

  def create
    if params[:api_key]
      @session = Session.new(api_key: params[:api_key])
      # @session.api_key = params[:api_key]
      Route.create(origin: params[:origin], destination: params[:destination], session_id: @session.id)
      if @session.save
        render json: { status: 200 }
      else
        render json: "The origin/destination is invalid."
      end
    else
      "An api key is needed for this action."
    end
  end

  def update
    if params[:action] == "add"
      restaurant = Restaurant.find_by(yelp_id: params[:yelp_id])
      @session.chosen_restaurants << restaurant
    elsif params[:action] == "delete"
      restaurant = Restaurant.find_by(yelp_id: params[:yelp_id])
      @session.chosen_restaurants.delete(restaurant)
    else
      render json: "Invalid action."
    end
  end

  private

  def session_params
    params.permit(:origin, :destination, :api_key)
  end

end
