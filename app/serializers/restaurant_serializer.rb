class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :opening_times
end
