class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.integer :restaurant_id
      t.string :name
      t.float :price
      t.timestamps
    end
  end
end
