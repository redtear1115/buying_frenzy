# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  before(:each) do
    @user = User.first
    @dish = Dish.first
  end
  # Edit user name
  describe 'PUT users' do
    it 'should be good' do
      @user = User.first
      params = {
        id: @user.id,
        name: 'new name'
      }
      put(:update, params: params)
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq('new name')

      params = {
        id: @user.id,
        name: @user.name
      }
      put(:update, params: params)
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq(@user.name)
    end
  end

  # Process a user purchasing a dish from a restaurant, handling all relevant data changes in an atomic transaction
  describe 'POST order' do
    it 'should be good' do
      params = {
        id: @user.id,
        dish_id: @dish.id
      }
      put(:order, params: params)
      data = JSON.parse(response.body)['data']
      expect(data['user_id']).to eq(@user.id)
      expect(data['dish_id']).to eq(@dish.id)
      expect(data['restaurant_id']).to eq(@dish.restaurant_id)
      expect(data['transaction_amount']).to eq(@dish.price)
      PurchaseHistory.find_by(id: data['id']).destroy
    end
  end
end
