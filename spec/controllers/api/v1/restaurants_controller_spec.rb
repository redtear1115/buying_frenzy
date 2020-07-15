# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RestaurantsController do
  before(:each) do
    @now = Time.parse('2020-07-15 14:30:00 UTC')
  end

  # List all restaurants that are open at a certain datetime
  describe 'GET open_at' do
    it 'should be good' do
      params = {
        timestamp: @now.to_i
      }
      get(:open_at, params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(17)
    end
  end

  # List all restaurants that are open on a day of the week, at a certain time
  describe 'GET open_on' do
    it 'should be good' do
      params = {
        day_of_week: 'Fri',
        time: @now.strftime("%H:%M")
      }
      get(:open_on, params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(2)
    end
  end

  # List all restaurants that are open for more or less than x hours per day or week
  describe 'GET opened' do
    it 'should be good' do
      params = {
        mode: 'more',
        hours: 16,
        per: 'day'
      }
      get(:opened, params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(69)
    end
  end

  # List all restaurants that have more or less than x number of dishes
  # List all restaurants that have more or less than x number of dishes within a price range
  describe 'GET filter' do
    it 'should be good' do
      params = {
        mode: 'more',
        dishes: 12,
        price_above: 10.0,
        price_below: 15.0,
      }
      get(:filter, params: params)
      data = JSON.parse(response.body)['data']
      expect(data.count).to eq(261)
    end
  end

  # Search for restaurants or dishes by name, ranked by relevance to search term
  describe 'GET search' do
    it 'should be good for restaurants' do
      @restaurant = Restaurant.first
      params = {
        terms: 'sushi,grill,japanese,bar',
        for: 'restaurants'
      }
      get(:search, params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(2197)
      expect(data.first['name']).to eq('iFish Japanese Grill & Sushi Bar')
      expect(data.last['id']).to eq(6)
      expect(data.last['name']).to eq('12th Ave. Grill')
    end

    it 'should be good for dishes' do
      @restaurant = Restaurant.first
      params = {
        terms: 'duck,grill,London,fillet',
        for: 'dishes'
      }
      get(:search, params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['id']).to eq(14828)
      expect(data.first['name']).to eq('Fan of Grill Duck Fillet')
      expect(data.last['id']).to eq(36)
      expect(data.last['name']).to eq('Fillet of Sole')
    end
  end
  
  # Edit restaurant name
  describe 'PUT restaurants' do
    it 'should be good' do
      @restaurant = Restaurant.first
      params = {
        id: @restaurant.id,
        name: 'new name',
      }
      put(:update, params: params)
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq('new name')

      params = {
        id: @restaurant.id,
        name: @restaurant.name,
      }
      put(:update, params: params)
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq(@restaurant.name)
    end
  end
end
