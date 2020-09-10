Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Home controller routes
  root  'home#index'
  get 'auth'  => 'home#auth'

  # Get login token from Knock
  post 'user_token' => 'user_token#create'

  # User actions
  get '/users'  => 'users#index'
  get '/users/current' => 'users#current'
  post '/users/create' => 'users#create'
  patch '/user/:id' => 'users#update'
  delete '/user/:id' => 'users#destroy'


  namespace :api, defaults: { format: 'json' } do
    resources :products, only: [:index, :show, :create, :update, :destroy] do
      delete 'image' => 'products#destroy_image'
    end

    resources :categories, only: [:index, :show, :create, :update]

    resources :orders, only: [:index, :show, :create, :update, :destroy] do
      # post 'products' => 'orders#add_product'
      # delete 'products' => 'orders#remove_product'
    end

    post 'orders/:id/:product_id' => 'orders#add_product'
    delete 'orders/:id/:product_id' => 'orders#remove_product'

    resources :order_products, only: [:create, :destroy]
  end

  

end

# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#   namespace :api, defaults: { format: 'json' } do
#     resources :todos, only: [:index, :show, :create, :update, :destroy] do
#       resources :steps, only: [:index, :create]
#     end

#     resources :steps, only: [:update, :destroy]
#   end

# end
