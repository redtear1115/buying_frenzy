# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DishesController do
  # List all dishes that are within a price range, sorted by price or alphabetically
  describe 'GET filter' do
    it 'should be sorted by price' do
      params = {
        sort: 'price',
        price_above: 10,
        price_below: 20,
      }
      get('filter', params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(494)
      expect(data.first['price']).to eq(10.0)
    end

    it 'should be sorted by name' do
      params = {
        sort: 'name',
        price_above: 10,
        price_below: 20,
      }
      get('filter', params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(5134)
      expect(data.first['name']).to eq("")
    end

    it 'should be sorted by price, name' do
      params = {
        sort: 'price,name',
        price_above: 10,
        price_below: 20,
      }
      get('filter', params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(2297)
      expect(data.first['price']).to eq(10.0)
      expect(data.first['name']).to eq("Apple Pie (a la Mode)")
    end

    it 'should be sorted by price desending and name ascending' do
      params = {
        sort: 'price:desc,name',
        price_above: 10,
        price_below: 20,
      }
      get('filter', params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(1025)
      expect(data.first['price']).to eq(20.0)
      expect(data.first['name']).to eq("American cream")
    end

    it 'should be sorted by price ascending and name descending' do
      params = {
        sort: 'price,name:desc',
        price_above: 10,
        price_below: 20,
      }
      get('filter', params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(17977)
      expect(data.first['price']).to eq(10.0)
      expect(data.first['name']).to eq("getaux")
    end
  end

  # Edit dish name, dish price
  describe 'PUT dishes' do
    it 'should be good' do
      @dish = Dish.first
      params = {
        id: @dish.id,
        name: 'new name',
        price: 23.33
      }
      put(:update, params: params)
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq('new name')
      expect(data['price']).to eq(23.33)

      params = {
        id: @dish.id,
        name: @dish.name,
        price: @dish.price
      }
      put(:update, params: params)
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq(@dish.name)
      expect(data['price']).to eq(@dish.price)
    end
  end
end
