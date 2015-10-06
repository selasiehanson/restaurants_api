class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.string :period
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
