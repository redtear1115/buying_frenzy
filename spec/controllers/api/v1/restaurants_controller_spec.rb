# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RestaurantsController do
  # List all restaurants that are open at a certain datetime
  # List all restaurants that are open on a day of the week, at a certain time
  describe 'GET open' do
    it 'should be good' do
    end
  end

  # List all restaurants that are open for more or less than x hours per day or week
  # List all restaurants that have more or less than x number of dishes
  # List all restaurants that have more or less than x number of dishes within a price range
  describe 'GET filter' do
    it 'should be good' do
    end
  end
  # Search for restaurants or dishes by name, ranked by relevance to search term
  describe 'GET search' do
    it 'should be good' do
    end
  end
  # Edit restaurant name, dish name, dish price and user name
  describe 'PUT restaurants' do
    it 'should be good' do
    end
  end
end
