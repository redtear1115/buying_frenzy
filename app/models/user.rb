class User < ApplicationRecord
  has_many :purchase_histories

  def order(dish)
    ActiveRecord::Base.transaction do
      self.cash_balance = self.cash_balance - dish.price
      self.save!
      dish.restaurant.cash_balance = dish.restaurant.cash_balance + dish.price
      dish.restaurant.save!
      purchase_histories.create(
        dish_id: dish.id,
        restaurant_id: dish.restaurant_id,
        transaction_amount: dish.price,
        transaction_at: Time.zone.now
      )
    end
  end
end
