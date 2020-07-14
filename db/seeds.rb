# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'importing restaurant_with_menu.json ...'
data = JSON.parse(File.read('./db/raw/restaurant_with_menu.json'))
data.each do |obj|
  rst = Restaurant.create(name: obj['restaurantName'], cash_balance: obj['cashBalance'])
  obj['menu'].each do |dish|
    rst.dishes.create(name: dish['dishName'], price: dish['price'])
  end

  obj['openingHours'].split('/').each do |opening_of_day|
    closed_apm = opening_of_day.split(' ')[-1]
    closed_time = opening_of_day.split(' ')[-2]
    opened_apm = opening_of_day.split(' ')[-4]
    opened_time = opening_of_day.split(' ')[-5]
    opened_at = Time.parse("#{opened_time} #{opened_apm} UTC")
    closed_at = Time.parse("#{closed_time} #{closed_apm} UTC")
    closed_at = closed_at + 1.day if closed_at <= opened_at

    ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat'].each_with_index do |day_of_week|
      next if opening_of_day.exclude?(day_of_week)
      rst.opening_hours.create(day_of_week: day_of_week, opened_at: opened_at, closed_at: closed_at)
    end
  end
end

puts 'importing users_with_purchase_history.json ...'
data = JSON.parse(File.read('./db/raw/users_with_purchase_history.json'))
data = data.take(10) if Rails.env.test?
data.each do |obj|
  user = User.create(id: obj['id'], name: obj['name'], cash_balance: obj['cashBalance'])
  obj['purchaseHistory'].each do |history|
    rst = Restaurant.find_by(name: history['restaurantName'])
    dish = rst.dishes.find_by(name: history['dishName'])
    user.purchase_histories.create(
      restaurant_id: rst.id,
      dish_id: dish.id,
      transaction_amount: history['transactionAmount'],
      transaction_at: Time.strptime("#{history['transactionDate']} UTC", "%m/%d/%Y %H:%M %P %Z")
    )
  end
end
