require "sidekiq/web"
Rails.application.routes.draw do
  # login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get  '/login_sample',   to: 'sessions#login_as_sample_user'
  delete '/logout',  to: 'sessions#destroy'

  # static pages
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  get  '/search',  to: 'atcoder_users#search'
  resources :users do
    member do
      get :following
    end
  end
  resources :relationships, only: [:create, :destroy]

  # sidekiq
  if Rails.env.development?
    mount Sidekiq::Web => "/sidekiq"
  end
end