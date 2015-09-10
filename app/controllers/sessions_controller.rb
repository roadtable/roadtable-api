class SessionsController < ApplicationController
  skip_before_action, only: :create

  def show
    render json: @session.chosen_restaurants
  end

  def create
    if params[:api_key]
      @session = Session.new(session_params)
      @session.api_key = params[:api_key]
      @session.route = Route.create(origin: params[:origin], destination: params[:destination])
      if @session.save
        render status: 200
      else
        render json: "The origin/destination is invalid."
      end
    else
      "An api key is needed for this action."
    end
  end

  def update
    if params[:action] == "add"
      restaurant = Restaurant.where(:id = params[:id]).first
      @session.chosen_restaurants << restaurant
    elsif params[:action] == "delete"
      restaurant = Restaurant.where(:id = params[:id]).first
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
