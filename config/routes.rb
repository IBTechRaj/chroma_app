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
    
    get 'products/category_list', to: 'products#category_list'
    get "products/filter", to: "products#filter_products"
     get "/products/search", to: "products#search"
    resources :products
    
    get 'carts/get_user_cart', to: 'carts#get_user_cart'
    patch "/carts/update_cart_item", to: "carts#update_cart_item"
    delete "/carts/remove_item/:id", to: "carts#remove_item" #, on: :collection
    post "/carts/add_item", to: "carts#add_item" #, on: :collection

      # resources :carts, only: [:show] do
      #   post "add_item", on: :collection
      #   delete "remove_item/:id", to: "carts#remove_item", on: :collection
      #   delete "clear_cart", on: :collection
      # end
      resources :orders, only: [:create, :show, :index]
  #   end
  # end
   
end

# end
