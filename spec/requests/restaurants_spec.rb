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

    def  create_opening_times      
      days.inject([]) do |result, day|
        result << FactoryGirl.build(:opening_time, day: day)
      end      
    end
  end
  
end