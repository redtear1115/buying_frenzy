class Api::V1::UsersController < Api::ApplicationController
  before_action :setup_user

  def update
    @user.name = params[:name]
    @user.save!
    ok_response(@user)
  end

  def order
    dish = Dish.find_by(id: params[:dish_id])
    error_response('dish not existed') && return if dish.nil?
    ok_response(@user.order(dish))
  end

  private

  def setup_user
    @user = User.find_by(id: params[:id])
    error_response('user not existed') && return if @user.nil?
  end
end
