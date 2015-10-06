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

require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  before do
    @menuItem = FactoryGirl.create(:menu_item)    
  end

  it { should belong_to(:menu) }
  it { validate_presence_of :menu_id }
  it { validate_presence_of :name }
  it { validate_presence_of :price }
end
