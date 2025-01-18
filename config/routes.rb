Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "cart_items/index"
      get "cart_items/show"
      get "cart_items/create"
      get "cart_items/update"
      get "cart_items/destroy"
      get "carts/index"
      get "carts/show"
      get "carts/create"
      get "carts/update"
      get "carts/destroy"
      get "categories/index"
      get "categories/show"
      get "categories/create"
      get "categories/update"
      get "categories/destroy"
      get "order_items/index"
      get "order_items/show"
      get "order_items/create"
      get "order_items/update"
      get "order_items/destroy"
      get "orders/index"
      get "orders/show"
      get "orders/create"
      get "orders/update"
      get "orders/destroy"
      get "product_items/index"
      get "product_items/show"
      get "product_items/create"
      get "product_items/update"
      get "product_items/destroy"
      get "products/index"
      get "products/show"
      get "products/create"
      get "products/update"
      get "products/destroy"
      get "users/index"
      get "users/show"
      get "users/create"
      get "users/update"
      get "users/destroy"
      resources :users, only: [:create, :show]
      resources :products, only: [:index, :show]
      resources :carts, only: [:show, :update]
      resources :orders, only: [:create, :show, :index]
    end
  end
end

end
