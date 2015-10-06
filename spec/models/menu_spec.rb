# == Schema Information
#
# Table name: menus
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  period        :string
#  start_date    :datetime
#  end_date      :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_menus_on_restaurant_id  (restaurant_id)
#

require 'rails_helper'

RSpec.describe Menu, type: :model do

  it { should validate_presence_of(:period) }
  it { should validate_presence_of(:restaurant_id) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  
  it { should have_many(:menu_items) }
  it { should belong_to(:restaurant) }
end
