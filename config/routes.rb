Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  # get  '/signup',  to: 'sessions#new'
  get  '/login_sample',   to: 'sessions#login_as_sample_user'
  delete '/logout',  to: 'sessions#destroy'
  get  '/search',  to: 'atcoder_users#search'
  # get  '/help',    to: 'static_pages#help'
  # get  '/login',   to: 'sessions#new'
  # post '/login',   to: 'sessions#create'
  resources :users do
    member do
      get :following
    end
  end
  resources :relationships, only: [:create, :destroy]
end