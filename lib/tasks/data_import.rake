namespace :data_import do
  desc 'Import restaurant_with_menu.json'
  task :restaurant_with_menu, [:file_path] => :environment do |_t, args|
    puts 'importing restaurant_with_menu.json ...'
    data = JSON.parse(File.read(args[:file_path]))
    data_count = data.count
    puts "creating Restaurant & Dish & OpeningHour (#{data_count} records) ..."
    data.each_with_index do |obj, index|
      puts "  #{index}/#{data_count}" if index % 100 == 0
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

        rst.opening_hours.day_of_weeks.each do |day_of_week, value|
          next if opening_of_day.exclude?(day_of_week)
          rst.opening_hours.create(day_of_week: value, opened_at: opened_at, closed_at: closed_at)
        end
      end
    end
  end

  desc 'Import users_with_purchase_history.json'
  task :users_with_purchase_history, [:file_path] => :environment do |_t, args|
    puts 'importing users_with_purchase_history.json ...'
    data = JSON.parse(File.read(args[:file_path]))
    data_count = data.count
    puts "creating User & PurchaseHistory (#{data_count} records) ..."
    data.each_with_index do |obj, index|
      puts "  #{index}/#{data_count}" if index % 100 == 0
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
  end
end
