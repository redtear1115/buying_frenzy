# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::HomeController do
  # The top x users by total transaction amount within a date range
  describe 'GET top_users' do
    it 'should be good' do
      params = {
        number: 10,
        from: '2020-01-01',
        to: '2020-03-01'
      }
      get('top_users', params: params)
      data = JSON.parse(response.body)['data']
      expect(data.first['user_id']).to eq(6)
      expect(data.first['amount']).to be > 45
      expect(data.last['user_id']).to eq(7)
      expect(data.last['amount']).to be < 11
    end
  end

  # The most popular restaurants by transaction volume, either by number of transactions or transaction dollar value
  describe 'GET most_popular' do
    it 'should be good with mode count' do
      params = {
        mode: 'count'
      }
      get('most_popular', params: params)
      data = JSON.parse(response.body)['data']
      expect(data['restaurant_id']).to eq(1097)
      expect(data['mode']).to eq('count')
      expect(data['score']).to eq(2)
    end

    it 'should be good with mode amount' do
      params = {
        mode: 'amount'
      }
      get('most_popular', params: params)
      data = JSON.parse(response.body)['data']
      expect(data['restaurant_id']).to eq(1547)
      expect(data['mode']).to eq('amount')
      expect(data['score']).to be > 30
    end
  end

  # Total number of users who made transactions above or below $v within a date range
  describe 'GET user_count' do
    it 'should be good with mode above' do
      params = {
        mode: 'above',
        amount: 25,
        from: '2020-01-01',
        to: '2020-03-01',
      }
      get('user_count', params: params)
      data = JSON.parse(response.body)['data']
      expect(data).to eq(2)
    end

    it 'should be good with mode below' do
      params = {
        mode: 'below',
        amount: 25,
        from: '2020-01-01',
        to: '2020-03-01',
      }
      get('user_count', params: params)
      data = JSON.parse(response.body)['data']
      expect(data).to eq(4)
    end
  end

  # The total number and dollar value of transactions that happened within a date range
  describe 'GET summary' do
    it 'should be good' do
      params = {
        from: '2020-01-01',
        to: '2020-03-01',
      }
      get('summary', params: params)
      data = JSON.parse(response.body)['data']
      expect(data['transaction_count']).to eq(12)
      expect(data['transaction_amount']).to be > 142
    end
  end
end
