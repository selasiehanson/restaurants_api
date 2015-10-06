class Api::V1::MenusController < ApplicationController
  before_filter :find_menu, only: [:show, :update, :destroy]
  # before_filter :find_restaurant, only: [:index]

  def index     
    render json: Menu.where(restaurant_id: params[:restaurant_id])
  end

  def create
    _params = menu_params
    _params[:restaurant_id] = params[:restaurant_id]
    menu = Menu.new(_params)
    if menu.save
      render json: menu, status: 201
    else 
      render json: error(menu), status: 400
    end
  end

  def update
    if @menu.update_attributes(menu_params)
      render json: @menu, status: 201
    else
      render json: error(menu), status: 400
    end
  end

  private
    def menu_params 
      # params.require(:menu).permit(:period, :start_date, :end_date).tap do |whitelisted|
      #   whitelisted[:menu_items] = params[:menu][:menu_items]
      # end

      pa = params.require(:menu).permit(:restaurant_id, :period, :start_date, :id,
        :end_date, {menu_items: [:id, :name, :description, :price, :menu_id]})

      pa[:menu_items_attributes] = []
      pa[:menu_items_attributes] = pa.delete :menu_items unless pa[:menu_items] == nil
      
      pa
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])  if params[:restaurant_id]
    end

    def find_menu
      @menu = Menu.find(params[:id]) if params[:id]
    end
end