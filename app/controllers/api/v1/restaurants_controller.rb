class Api::V1::RestaurantsController < ApplicationController
  def index
    render json: Restaurant.all
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: restaurant
    else
      render json: error(restaurant), status: 400
    end
  end

  def show

  end

  def update

  end

  def destroy

  end

  private 
    def restaurant_params
      params.require(:restaurant).permit(:name, :description)
    end
end
