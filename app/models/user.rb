class User < ApplicationRecord
  has_many :purchase_histories

  def order(dish)
    purchase_histories.create(
      dish_id: dish.id,
      restaurant_id: dish.restaurant_id,
      transaction_amount: dish.price,
      transaction_at: Time.zone.now
    )
  end
end
