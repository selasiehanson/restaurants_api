# == Schema Information
#
# Table name: opening_times
#
#  id            :integer          not null, primary key
#  day           :string
#  opens_at      :datetime
#  closes_at     :datetime
#  restaurant_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_opening_times_on_restaurant_id  (restaurant_id)
#

require 'rails_helper'

RSpec.describe OpeningTime, type: :model do
  
  before do
    @op_time = OpeningTime.new
  end

  it { expect(@op_time).to respond_to(:day) }
  it { expect(@op_time).to respond_to(:opens_at) }
  it { expect(@op_time).to respond_to(:closes_at) }
  it { expect(@op_time).to respond_to(:restaurant_id) }
  it { should belong_to(:restaurant) }

end
