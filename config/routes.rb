Rails.application.routes.draw do
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  resource :sessions, only: [:create]
  
  get 'users/new'
  get '/register', to: 'users#new'
  resources :users
  
  root "posts#index"
  resources :posts do
    resources :comments
  end

  get "comments/export"
end
