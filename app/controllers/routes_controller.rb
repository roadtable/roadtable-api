class RoutesController < ApplicationController
  def show
    if params[:filter]
      filter = params[:filter]
      @filtered_restaurants = @session.route.available_restaurants.select do |r|
        r.name.include?(filter) || r.name.include?(filter.capitalize) || r.categories.include?(filter) || r.categories.include?(filter.capitalize)
      end

      render json: @filtered_restaurants
    else
      @restaurants = @session.route.available_restaurants
      render json: @restaurants
    end
  end

end
