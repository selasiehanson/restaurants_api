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

class Menu < ActiveRecord::Base

  validates_presence_of :period, :start_date, :end_date, :restaurant_id

  has_many :menu_items, dependent: :destroy
  belongs_to :restaurant

  accepts_nested_attributes_for :menu_items
end
