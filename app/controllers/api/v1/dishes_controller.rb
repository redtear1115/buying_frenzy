class Api::V1::DishesController < Api::ApplicationController
  def filter
    from = params[:price_above].to_f
    to = params[:price_below].to_f || 999999
    error_response('please enter valid price range') && return if from >= to
    dishes = Dish.where(price: from..to).order(order_conditions).limit(100)
    ok_response(dishes)
  end

  def update
    dish = Dish.find_by(params[:id])
    error_response('dish not existed') && return if dish.nil?
    dish.name = params[:name]
    dish.price = params[:price].to_f
    dish.save!
    ok_response(dish)
  end

  private

  def order_conditions
    result = {}
    params[:sort].split(',').each do |sort_cond|
      sort_cond.split(':').each_slice(2) do |key, dir|
        next unless key == 'name' || key == 'price'
        dir ||= 'asc'
        next unless  dir == 'asc' || dir == 'desc'
        result[key.to_sym] = dir.to_sym
      end
    end
    result
  end
end
