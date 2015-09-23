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

FactoryGirl.define do
  factory :restaurant do
    name "res 1"
    description "a nice restaurant"
  end

end
