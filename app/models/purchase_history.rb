class PurchaseHistory < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :restaurant
end
