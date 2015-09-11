class SessionsController < ApplicationController
  skip_before_action :set_session, only: :create

  def show
    render json: @session.chosen_restaurants
  end

  def create
    if params[:api_key]
      @session = Session.new(api_key: params[:api_key])
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
    if params[:akushon] == "add"
      restaurant = @session.route.available_restaurants.where(yelp_id: params[:yelp_id]).first
      # This is not ideal, but is a workaround for https://github.com/apotonick/reform/issues/143
      @session.chosen_restaurants.batch_insert([restaurant])
    elsif params[:akushon] == "delete"
      restaurant = @session.route.available_restaurants.where(yelp_id: params[:yelp_id]).first
      @session.chosen_restaurants.delete(restaurant)
      @session.save
    else
      render json: "Invalid action."
    end
  end

  private

  def session_params
    params.permit(:api_key)
  end

end
