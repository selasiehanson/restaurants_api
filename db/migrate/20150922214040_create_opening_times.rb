class CreateOpeningTimes < ActiveRecord::Migration
  def change
    create_table :opening_times do |t|
      t.string :day
      t.datetime :opens_at
      t.datetime :closes_at
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
