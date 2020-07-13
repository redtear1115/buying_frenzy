class CreateOpeningHours < ActiveRecord::Migration[6.0]
  def change
    create_table :opening_hours do |t|
      t.integer :restaurant_id
      t.integer :day_of_week
      t.time :opened_at
      t.time :closed_at
      t.float :open_hour
      t.timestamps
    end
  end
end
