Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :home do
        get 'top_users'
        get 'most_popular'
        get 'user_count'
        get 'summary'
      end

      resources :users, only: [:update]
      namespace :users do
        post 'order'
      end

      resources :restaurants, only: [:update]
      namespace :restaurants do
        get 'open'
        get 'filter'
        get 'search'
      end

      resources :dishes, only: [:update]
      namespace :dishes do
        get 'filter'
      end
    end
  end

  root to: 'home#index'
end
