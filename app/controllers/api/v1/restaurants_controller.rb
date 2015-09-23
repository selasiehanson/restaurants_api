class Api::V1::RestaurantsController < ApplicationController
  def index
    render json: Restaurant.all
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end
end
