class CreatePurchaseHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_histories do |t|
      t.integer :user_id
      t.integer :dish_id
      t.integer :restaurant_id
      t.float :transaction_amount
      t.datetime :transaction_at
      t.timestamps
    end
  end
end
