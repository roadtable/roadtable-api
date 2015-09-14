class RoutesController < ApplicationController
  def show
    @restaurants = @session.route.available_restaurants
    render json: @restaurants
  end

  def filter
    @restaurants = @session.route.available_restaurants
    @filtered_restaurants = []
    filtering_params(params[:filter]).each do |key, value|
      @restaurants.each do |restaurant|
        if restaurant.public_send(key).include?(value) || restaurant.public_send(key).include?(value.capitalize) || restaurant.public_send(key).include?(value.downcase)
          @filtered_restaurants << restaurant
        end
      end
    end
    render json: @filtered_restaurants
  end

  private

  def filtering_params(filter_value)
    filter_hash = {:name => filter_value, :categories => filter_value}
  end

end
