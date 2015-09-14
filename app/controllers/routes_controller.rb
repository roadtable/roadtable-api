class RoutesController < ApplicationController

  def show
    @restaurants = @session.route.available_restaurants
    render json: @restaurants
  end

  def filter
    @restaurants = @session.route.available_restaurants.filter(params.slice(:name, :categories))
    render json: @restaurants
  end

end
