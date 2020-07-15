class OpeningHour < ApplicationRecord
  belongs_to :restaurant
  enum day_of_week: ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat']

  before_save :setup_open_hour, if: :will_save_change_to_opened_at? || :will_save_change_to_closed_at?

  def self.restaurants
    Restaurant.where(id: distinct(:restaurant_id).pluck(:restaurant_id))
  end

  def self.between(day_of_week, datetime)
    standard_time = Time.parse("2000-01-01 #{datetime.strftime('%H:%M:%S')} UTC")
    self.where(day_of_week: day_of_week).where('opened_at < ? AND closed_at > ?', standard_time, standard_time)
  end

  def to_next_day?
    closed_at <= opened_at
  end

  private

  def setup_open_hour
    open_seconds = closed_at - opened_at
    open_seconds = open_seconds + 1.day if to_next_day?
    self.open_hour = open_seconds / 3600.0
  end
end
