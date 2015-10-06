class MenuSerializer < ActiveModel::Serializer
  attributes :id, :period, :start_date, :end_date
  has_many :menu_items
end
