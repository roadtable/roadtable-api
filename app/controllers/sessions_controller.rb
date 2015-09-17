class SessionsController < ApplicationController
  skip_before_action :set_session, only: :create

  def show
    render json: @session.chosen_restaurants
  end

  def create
    if params[:api_key]
      @session = Session.create(api_key: params[:api_key])
      @route = Route.create(origin: params[:origin], destination: params[:destination], session_id: @session.id)
      if @session.save
        render json: { status: 200 }
      else
        render json: { errors: "The origin/destination is invalid.", status: 500 }
      end
    else
      render json: { errors: "An api key is needed for this action.", status: 500 }
    end
  end

  def update
    if params[:akushon] == "add"
      restaurant = @session.route.available_restaurants.where(yelp_id: params[:yelp_id]).first
      # This is not ideal, but is a workaround for https://github.com/apotonick/reform/issues/143
      unless @session.chosen_restaurants.include?(restaurant)
        @session.chosen_restaurants.batch_insert([restaurant])
      end
    elsif params[:akushon] == "delete"
      restaurant = @session.route.available_restaurants.where(yelp_id: params[:yelp_id]).first
      @session.chosen_restaurants.delete(restaurant)
      @session.save
    else
      render json: { errors: "Invalid action." }
    end
  end

  private

  def session_params
    params.permit(:api_key)
  end

end
