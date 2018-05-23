Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/welcome' => 'welcome#new'

  post '/stores/:store_id/products/:product_id/reviews/:id', to: 'reviews#update'

  jsonapi_resources :stores do 
    jsonapi_resources :products do 
      jsonapi_resources :reviews, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end 
  end 

  get '/logout' => 'sessions#destroy'

  jsonapi_resources :sessions, only: [:new, :create]

  post 'users/:id', to: 'users#update'

  jsonapi_resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  


end
