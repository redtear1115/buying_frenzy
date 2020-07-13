# README

This is a demo project for Technical Assessment from glints

## Requirements
[Buying Frenzy](https://gist.github.com/seahyc/97b154ce5bfd4f2b6e3a3a99a7b93f69)

## Model
### Restaurant
* has_many :dishes
* has_many :opening_hours
* name
* cash_balance

### Dish
* belongs_to :restaurant
* name
* price

### OpeningHour
* belongs_to :restaurant
* day_of_week
* opened_at
* closed_at
* opening_hour

### User
* has_many :purchase_histories
* name
* cash_balance

### PurchaseHistory
* belongs_to :user
* belongs_to :dish
* belongs_to :restaurant
* transaction_amount
* transaction_date

## API Document

## RSpec Result

## Coverage
