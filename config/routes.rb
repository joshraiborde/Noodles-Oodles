Rails.application.routes.draw do
  root 'noodles#index'
  get '/' => 'sessions#welcome'
  get '/auth/:provider/callback' => 'sessions#create'
  # post '/auth/:provider/callback', to: 'sessions#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'

  resources :reviews
  resources :noodles do
    resources :reviews, only: [:new, :index]
  end
  resources :brands
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
