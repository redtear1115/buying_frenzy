Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :home do
        # The top x users by total transaction amount within a date range
        get 'top_users'
        # The most popular restaurants by transaction volume, either by number of transactions or transaction dollar value
        get 'most_popular'
        # Total number of users who made transactions above or below $v within a date range
        get 'user_count'
        # The total number and dollar value of transactions that happened within a date range
        get 'summary'
      end

      namespace :users do
        # Edit restaurant name, dish name, dish price and user name
        put 'users'
        # Process a user purchasing a dish from a restaurant, handling all relevant data changes in an atomic transaction
        post 'order'
      end

      namespace :restaurants do
        # List all restaurants that are open at a certain datetime
        # List all restaurants that are open on a day of the week, at a certain time
        get 'open'
        # List all restaurants that are open for more or less than x hours per day or week
        # List all restaurants that have more or less than x number of dishes
        # List all restaurants that have more or less than x number of dishes within a price range
        get 'filter'
        # Search for restaurants or dishes by name, ranked by relevance to search term
        get 'search'
        # Edit restaurant name, dish name, dish price and user name
        put 'restaurants'
      end

      namespace :dishes do
        # List all dishes that are within a price range, sorted by price or alphabetically
        get 'filter'
        # Edit restaurant name, dish name, dish price and user name
        put 'dishes'
      end
    end
  end

  root to: 'home#index'
end
