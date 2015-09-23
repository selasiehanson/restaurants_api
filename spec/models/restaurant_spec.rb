# == Schema Information
#
# Table name: restaurants
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  before do 
    @restaurant = Restaurant.new
  end

  it { expect(@restaurant).to respond_to(:name) }
  it { expect(@restaurant).to respond_to(:description) }
  it { should have_many(:opening_times) }

  #validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
