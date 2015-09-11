class RoutesController < ApplicationController

  def show
    @restaurants = @session.route.restaurants
    render json: @restaurants
  end

end
