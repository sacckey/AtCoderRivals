Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  # get 'users/new'
  # get 'sessions/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'sessions#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get   '/login_sample',   to: 'sessions#login_as_sample_user'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end