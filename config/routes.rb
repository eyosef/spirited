Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/welcome' => 'welcome#new'

  # get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get '/auth/:provider/callback', :to => 'sessions#create'
  get 'auth/failure', to: redirect('/welcome')
  get 'signout/:id', :to => 'sessions#destroy', as: "signout"
  # get '/login', :to => 'sessions#new', :as => :login 
  # match '/auth/failure', to: redirect('/welcome')
  # get 'auth/google_oauth2', to: 'sessions#create'

  post '/stores/:store_id/products/:product_id/reviews/:id', to: 'reviews#update'

  get '/delete_review' => 'reviews#destroy'

  jsonapi_resources :stores do 
    jsonapi_resources :products do 
      jsonapi_resources :reviews, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end 
  end 


  jsonapi_resources :sessions, only: [:new, :create]

  post 'users/:id', to: 'users#update'

  jsonapi_resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  


end