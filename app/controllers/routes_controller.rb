class RoutesController < ApplicationController

  def show
    @restaurants = @session.route.available_restaurants
    render json: @restaurants
  end

end
