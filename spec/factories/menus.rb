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

FactoryGirl.define do
  factory :menu do
    restaurant nil
    period "breakfast"
    start_date "2015-09-24 18:36:56"
    end_date "2015-09-24 18:36:56"
  end

end
