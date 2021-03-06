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

class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :opening_times
end
