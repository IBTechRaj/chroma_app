# Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  Rails.application.routes.draw do
    
  # namespace :api do
  #   namespace :v1 do

      get 'categoryProduct', to: 'categories#index'
      
    post 'users/login', to: 'users#login'
    post 'users/logout', to: 'users#logout'
    get 'users/current_user', to: 'users#current_user'
     resources :users
      resources :products
      resources :carts, only: [:show, :update]
      resources :orders, only: [:create, :show, :index]
  #   end
  # end
   
end

# end
