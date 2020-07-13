class User < ApplicationRecord
  has_many :purchase_histories

  def self.top(daterange, number)
    binding.pry
    return self.first
  end
end
