require 'rails_helper'

describe 'Restuarant Api', type: :request do 

  before do
    @route = '/api/v1/restaurants'
  end

  it 'should return an empty list' do
    xhr :get, @route
    expect(response).to be_success
    expect(json).to eq([])
  end

  context 'fecthing restaurants after they have been created' do
    before do             
      FactoryGirl.create(:restaurant, name: 'res1', opening_times: create_opening_times)
      FactoryGirl.create(:restaurant, name: 'res2', opening_times: create_opening_times)      
    end  

    it 'should return 2 restaurants' do
      xhr :get, @route
      restaurants_count =  json.length
      expect(restaurants_count).to eq(2)
    end

    it 'should return the opening times with the results' do
      xhr :get, @route

      first =  json.first
      opening_times_count = first['opening_times'].count
      mapped_days = first['opening_times'].map {|x| x['day'] }
            
      expect(opening_times_count).to eq(7)
      expect(mapped_days.sort).to eq(days.sort)
    end

    def days
      %w(sun mon tue wed thu fri sat)
    end

    def create_opening_times      
      days.inject([]) do |result, day|
        result << FactoryGirl.build(:opening_time, day: day)
      end      
    end
  end

  context 'creating a restaurant' do
    before do
      @new_restaurant_params = {
        restaurant: {
          name: 'A nice restaurant',
          description: 'Serving with delight.'
        }
      }
    end

    it 'creates a new restaurant' do
      xhr :post, @route, @new_restaurant_params

      expect(response.status).to eq(201)
      expect(json['name']).to eq('A nice restaurant')
      expect(json['description']).to eq('Serving with delight.')
    end

    it 'does not create a restaurant but returns errors instead' do
      @new_restaurant_params[:restaurant][:name] = nil
      xhr :post, @route, @new_restaurant_params
      
      expect(response.status).to eq(400)
      expect(json['code']).to eq('validation_errors')
      expect(json['problem']).to eq("Name can't be blank")
      expect(json['validation_errors']).not_to be_nil      
    end
  end

  context 'fecthing a restaurant' do 
     before do
      @res = FactoryGirl.create(:restaurant,name: 'cool chop')
     end

     it 'returns a single restaurant with a valid id' do
        xhr :get, "#{@route}/#{@res.id}"

        expect(response.status).to eq(200)
        expect(json['name']).to eq('cool chop')
     end

     it 'returns an error for an invalid' do
      xhr :get, "#{@route}/10000"

      expect(response.status).to eq(404)        
      expect(json['code']).to eq('record_not_found')
      expect(json['error']).to include("Couldn't find")
     end     
  end

  context 'updating  a restaurant'  do
    before do
      @res = FactoryGirl.create(:restaurant,name: 'cool chop')
      @new_name = "new cool chop"
      @new_desc = 'some new description'
      @update_params = {
        restaurant: {
          name: @new_name,
          description: @new_desc
        }
      }
    end

    it 'updates the restaurant with new attributes' do
      xhr :put, "#{@route}/#{@res.id}", @update_params

      expect(response.status).to eq(200)
      expect(json['name']).to eq(@new_name)
      expect(json['description']).to eq(@new_desc)
    end

    it 'updates the restaurant with new attributes' do
      @update_params[:restaurant][:name] = ''
      xhr :put, "#{@route}/#{@res.id}", @update_params

      expect(response.status).to eq(400)
      expect(json['code']).to eq('validation_errors')
      expect(json['validation_errors']).not_to be_nil      
    end    
  end

  context 'deleting a restuarant' do
      before do
        @res = FactoryGirl.create(:restaurant,name: 'cool chop')
      end

      it 'deletes a restuarant' do
        xhr :delete, "#{@route}/#{@res.id}"
        expect(response.status).to eq(204)
      end

      it 'returns and ivalid status for an unknown restuarant' do
        xhr :delete, "#{@route}/10101010"
        expect(response.status).to eq(404)
      end
    end
  
end