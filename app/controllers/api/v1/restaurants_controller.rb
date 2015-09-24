class Api::V1::RestaurantsController < ApplicationController
  
  def index
    render json: Restaurant.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant, status: 201
    else
      render json: error(@restaurant), status: 400
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    if @restaurant
      render json: @restaurant
    else
      render json: error(@restaurant, Restaurant.name.downcase), status: 400
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      render json: @restaurant
    else
      render json: error(@restaurant), status: 400
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    head :no_content
  end

  private 
    def restaurant_params
      params.require(:restaurant).permit(:name, :description)
    end

    def not_found()
    end
end
