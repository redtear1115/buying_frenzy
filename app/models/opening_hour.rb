class OpeningHour < ApplicationRecord
  belongs_to :restaurant
  enum day_of_week: ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat']

  before_save :setup_open_hour, if: :will_save_change_to_opened_at? || :will_save_change_to_closed_at?

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
