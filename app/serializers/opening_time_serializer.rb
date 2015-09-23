class OpeningTimeSerializer < ActiveModel::Serializer
  attributes :id, :day, :opens_at, :closes_at
  
  belongs_to :restaurant
end
