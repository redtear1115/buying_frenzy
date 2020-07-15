class Api::V1::RestaurantsController < Api::ApplicationController
  before_action :setup_mode

  def update
    restaurant = Restaurant.find_by(params[:id])
    error_response('restaurant not existed') && return if restaurant.nil?
    restaurant.name = params[:name]
    restaurant.save!
    ok_response(restaurant)
  end

  def open_at
    datetime = Time.at(params[:timestamp].to_i)
    ohs = OpeningHour.between(datetime.strftime('%a'), datetime)
    ok_response(ohs.restaurants)
  end

  def open_on
    error_response('invalid day of week') && return unless OpeningHour.day_of_weeks.keys.include? params[:day_of_week]
    datetime = Time.parse(params[:time])
    ohs = OpeningHour.between(params[:day_of_week], datetime)
    ok_response(ohs.restaurants)
  end

  def opened
    case params[:per]
    when 'day'
      weekly_open_hours = params[:hours].to_f * 7
    when 'week'
      weekly_open_hours = params[:hours].to_f
    else
      error_response('invalid per value') && return
    end
    sum_by_restaurant_id = OpeningHour.group(:restaurant_id).having("sum(open_hour) #{@operators[params[:mode]]} #{weekly_open_hours}").sum(:open_hour)
    ok_response(Restaurant.where(id: sum_by_restaurant_id.keys))
  end

  def filter
    if params[:price_above].present? && params[:price_below].present?
      from = params[:price_above].to_f
      to = params[:price_below].to_f || 999999
      error_response('please enter valid price range') && return if from >= to
      count_by_restaurant_id = Dish.group(:restaurant_id).where(price: from..to).having("count(id) #{@operators[params[:mode]]} #{params[:dishes]}").count(:id)
    else
      count_by_restaurant_id = Dish.group(:restaurant_id).having("count(id) #{@operators[params[:mode]]} #{params[:dishes]}").count(:id)
    end
    ok_response(Restaurant.where(id: count_by_restaurant_id.keys))
  end

  def search
    case params[:for]
    when 'restaurants'
      ok_response(Restaurant.search(params[:terms]))
    when 'dishes'
      ok_response(Dish.search(params[:terms]))
    else
      error_response('invalid for value') && return
    end
  end

  private

  def setup_mode
    return if params[:mode].nil?
    @operators = {
      'more' => '>',
      'less' => '<'
    }
    error_response('invalid mode value') && return unless @operators.include? params[:mode]
  end
end
