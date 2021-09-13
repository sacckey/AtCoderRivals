require "sidekiq/web"
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:update] do
        member do
          get :following
        end
      end

      resources :atcoder_users, only: [:show], param: :atcoder_id do
        member do
          post :follow
          delete :unfollow
          get :submissions
          get :contests
        end
      end

      namespace :timeline do
        get :submissions
        get :contests
      end

      namespace :sessions do
        get :auth_user
        post :sample_login
      end
      resources :sessions, only: [:create]

      namespace :admin do
        resources :users, only: [:index]
        resources :atcoder_users, only: [:index]
        resources :contests, only: [:index]
        resources :problems, only: [:index]
        resources :submissions, only: [:index]
        resources :histories, only: [:index]
      end
    end
  end

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
