# == Schema Information
#
# Table name: menu_items
#
#  id          :integer          not null, primary key
#  menu_id     :integer
#  name        :string
#  description :string
#  price       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_menu_items_on_menu_id  (menu_id)
#

class MenuItem < ActiveRecord::Base
  validates_presence_of :name, :price
  belongs_to :menu
end
