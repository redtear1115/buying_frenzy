# README

This is a demo project for Technical Assessment from glints

## Requirements
[Buying Frenzy](https://gist.github.com/seahyc/97b154ce5bfd4f2b6e3a3a99a7b93f69)

## Demo Site
[Heroku](https://still-depths-44807.herokuapp.com/)

## Setup Database
* rake db:create
* rake db:migrate
* rake data_import:restaurant_with_menu[PATH_TO_YOUR_FILE]
* rake data_import:users_with_purchase_history[PATH_TO_YOUR_FILE]

## API Document
[Postman](https://github.com/redtear1115/buying_frenzy/blob/master/buying_frenzy.json)

## RSpec Result
* Api::V1::DishesController
  * GET filter
    * should be sorted by price
    * should be sorted by name
    * should be sorted by price, name
    * should be sorted by price descending and name ascending
    * should be sorted by price ascending and name descending
  * PUT dishes
    * should be good

* Api::V1::HomeController
  * GET top_users
    * should be good
  * GET most_popular
    * should be good with mode count
    * should be good with mode amount
  * GET user_count
    * should be good with mode above
    * should be good with mode below
  * GET summary
    * should be good

* Api::V1::RestaurantsController
  * GET open_at
    * should be good
  * GET open_on
    * should be good
  * GET opened
    * should be good
  * GET filter
    * should be good
  * GET search
    * should be good for restaurants
    * should be good for dishes
  * PUT restaurants
    * should be good

* Api::V1::UsersController
  * PUT users
    * should be good
  * POST order
    * should be good

Finished in 5.68 seconds (files took 2.47 seconds to load)
21 examples, 0 failures

## Coverage
* All Files ( 97.0% covered at 3.15 hits/line )

* app/models/opening_hour.rb
  * 75.0 %
* app/controllers/api/application_controller.rb
	* 90.00 %
* app/controllers/api/v1/restaurants_controller.rb
	* 90.48 %
* app/controllers/api/v1/dishes_controller.rb
	* 100.00 %
* app/controllers/api/v1/home_controller.rb
	* 100.00 %
* app/controllers/api/v1/users_controller.rb
	* 100.00 %
* app/controllers/application_controller.rb
	* 100.00 %
* app/models/application_record.rb
	* 100.00 %
* app/models/concerns/name_searchable.rb
	* 100.00 %
* app/models/dish.rb
	* 100.00 %
* app/models/purchase_history.rb
	* 100.00 %
* app/models/restaurant.rb
	* 100.00 %
* app/models/user.rb
	* 100.00 %
* spec/controllers/api/v1/home_controller_spec.rb
	* 100.00 %
* spec/controllers/api/v1/restaurants_controller_spec.rb
	* 100.00 %
* spec/controllers/api/v1/users_controller_spec.rb
	* 100.00 %
