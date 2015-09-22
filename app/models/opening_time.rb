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

class OpeningTime < ActiveRecord::Base
  belongs_to :restaurant
end
