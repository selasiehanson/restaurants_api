class Api::V1::RestaurantsController < ApplicationController
  
  before_filter :find_restaurant, only: [:show, :update, :destroy]

  def index
    render json: Restaurant.all
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: 201
    else
      render json: error(restaurant), status: 400
    end
  end

  def show    
    render json: @restaurant    
  end

  def update
    if @restaurant.update_attributes(restaurant_params)
      render json: @restaurant
    else
      render json: error(@restaurant), status: 400
    end
  end

  def destroy    
    @restaurant.destroy
    head :no_content
  end

  protected 
    def find_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :description)
    end
end
