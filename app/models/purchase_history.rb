class PurchaseHistory < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :restaurant

  def self.top_users(daterange, limit)
    phs = self.select('user_id, SUM(transaction_amount) as amount')
      .where(transaction_at: daterange)
      .group(:user_id)
      .order('amount desc')
      .limit(limit)

    phs.map do |ph|
      {
        user_id: ph.user.id,
        user_name: ph.user.name,
        amount: ph.amount,
      }
    end
  end

  def self.most_popular(mode)
    case mode
    when 'amount'
      phs = self.select('restaurant_id, SUM(transaction_amount) as score')
        .group(:restaurant_id)
        .order('score desc')
        .limit(1)
    when 'count'
      phs = self.select('restaurant_id, count(id) as score')
        .group(:restaurant_id)
        .order('score desc')
        .limit(1)
    end
    ph = phs.first
    {
      restaurant_id: ph.restaurant_id,
      restaurant_name: ph.restaurant.name,
      mode: mode,
      score: ph.score
    }
  end

  def self.user_count(daterange, mode, amount)
    operators = {
      'above' => '>',
      'below' => '<'
    }
    phs = self.select('user_id, SUM(transaction_amount) as amount')
      .where(transaction_at: daterange)
      .group(:user_id)
      .having("amount #{operators[mode]} #{amount}")
    phs.map{|ph| ph.user_id}.count
  end

  def self.summary(daterange)
    phs = self.select('user_id, COUNT(id) as count, SUM(transaction_amount) as amount').where(transaction_at: daterange)
    ph = phs.first
    {
      transaction_count: ph.count,
      transaction_amount: ph.amount
    }
  end
end
