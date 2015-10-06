require 'rails_helper'

describe 'Restuarant Api', type: :request do 

  before do
    @res = FactoryGirl.create(:restaurant, name: 'SamDees')
    create_test_menu(@res)
    
    @route = "/api/v1/restaurants/#{@res.id}/menus"
  end

  context 'fecthing menus for a resturant' do
      
    before do
      res2 = FactoryGirl.create(:restaurant, name: 'Another Restuarant')
      create_test_menu(res2)
    end

    it 'should fetch menu for a the current day if day is not provided' do
      xhr :get, @route
      expect(response).to be_success
      menu_count = json.length          
      expect(menu_count).to eq(3)
    end

    it 'should menu items' do
      xhr :get, @route      

      breakfast = json[0]
      lunch = json[1]
      dinner = json[2]

      expect(breakfast['menu_items'].count).to eq(3)
      expect(lunch['menu_items'].count).to eq(2)
      expect(dinner['menu_items'].count).to eq(3)
    end

    it 'should return name description and price fields for menutiems' do      
      xhr :get, @route      
      menu_item_fields = ['name', 'description', 'price', 'id'].sort
      breakfast_menu_items = json[0]['menu_items']
      breakfast_menu_items.first.keys      
      expect(breakfast_menu_items.first.keys.sort).to eq(menu_item_fields)
    end
  end

  context "creating a menu" do
    before do   
      res = FactoryGirl.create(:restaurant, name: 'Another Restuarant')
      @params = {
        menu: {
          period: 'break_fast',
          start_date: Time.now.beginning_of_month,
          restaurant_id: res.id,
          end_date: Time.now.end_of_month,
          menu_items: [
            {name: 'Scrambled Ostrich Eggs' , price: '18.99'},
            {name: 'Goat salad' , price: '8.99'}
          ]
        }
      }
    end

    it 'should create a menu' do
      xhr :post, @route, @params

      expect(response).to be_success
      expect(json).not_to be_empty
      menu_items = json['menu_items']
      expect(menu_items.count).to be(2)
      # p menu_items
      names = menu_items.map { |x| x['name'].downcase }.sort
      expect(names).to eq(['scrambled ostrich eggs', 'goat salad'].sort)
    end

  end

  context 'updating a menu and an item'  do
    before do
      @res2 = FactoryGirl.create(:restaurant, name: 'Another Restuarant')
      @m = create_menu('breakfast',@res2)
      @m_item = create_menu_item('scrambled eggsz', '10.99',@m)
      @update_route = "#{@route}/#{@m.id}"            
    end

    it "should update the menu and it's items" do
      @params = {
        menu: {
          period: 'brunch',
          restaurant_id: @res2.id          
        }
      }
      xhr :put, @update_route, @params      
      expect(response).to be_success
      expect(json['period']).to eq('brunch')
    end

    it "should update the menu and it's items" do
      @params = {
        menu: {          
          restaurant_id: @res2.id, 
          menu_items: [
            {
              id: @m_item.id,
              name: 'scrambled eggs',
              price: '12.99'
            }
          ]
        }
      }
      xhr :put, @update_route, @params      
      expect(response).to be_success     
      expect(json['menu_items'].count).to eq(1)
      expect(json['menu_items'][0]['name']).to eq('scrambled eggs') 
      expect(json['menu_items'][0]['price']).to eq('12.99') 
    end
  end

  context 'deleting a menu' do    
    before do
      @menu = create_menu('brunch',@res)
      @menu_item = create_menu_item('goat salad', '10.99', @menu)
      @menu_route = "#{@route}/#{@menu.id}"      
    end

    it "should delete a menu"  do      

      xhr :delete, @menu_route
      expect(response).to be_success
      expect(response.status).to eq(204)      
    end

    describe "should delete menu items as well" do
      before do
        xhr :delete, @menu_route
      end

      it do
        expect(Menu.find_by(id: @menu.id)).to be_nil
        expect(MenuItem.find_by(menu_id: @menu.id)).to be_nil
      end
    end
  end

  # plumbing
  def create_test_menu(res)
    breakfast_menu = create_menu('breakfast', res)
    lunch_menu = create_menu('lunch', res)
    dinner_menu = create_menu('dinner', res)

    [
      ['BACON & SYRUP TRIPLE STACK PANCAKES', '5.0'],
      ['SMOKED SALMON BAGEL', '6.0'],
      ['EGGS ROYALE', '6.95']
    ].each do |breakfast|
      create_menu_item(breakfast[0], breakfast[1], breakfast_menu)
    end

    [
      ['HAMBURGER', '5.99'],
      ['MARGHERITA PIZZA','5.99']
    ].each do |lunch|
      create_menu_item(lunch[0], lunch[1], lunch_menu)
    end

    [
      ['CALAMARI', '8.56'],
      ['RISOTTO CAKES','6.32'],
      ['CAPRESE SALAD','4.99']
    ].each do |dinner|
      create_menu_item(dinner[0], dinner[1], dinner_menu)
    end

  end

  def create_menu (period,restaurant)
    FactoryGirl.create(:menu,restaurant: restaurant, period: period,
      start_date:Time.now.beginning_of_month, end_date: Time.now.end_of_month)    
  end

  def create_menu_item(name, price, menu)
    FactoryGirl.create(:menu_item, menu: menu, name: name, price: price)
  end
end