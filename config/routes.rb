Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %w[index show update]
      resources :current_user, only: %w[index]
      resources :works, only: %w[index create show update destroy]
      resources :libraries, only: %w[index create show update destroy]
      resources :library_works, only: %w[index create show update destroy]
      resources :relationships, only: %w[create destroy]
      resources :reset_password, only: %w[create]
      post '/update_password', to: 'reset_password#update_password'
      get '/search_works', to: 'search#search_works'
      get '/search_library_works', to: 'search#search_library_works'
      get '/search_following_colleagues', to: 'search#search_following_colleagues'
      get '/search_all_colleagues', to: 'search#search_all_colleagues'
      resources :users do
        member do
          get :following, :followers
        end
      end
    end
  end


  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'api/login',
      sign_out: 'api/logout',
      registration: 'api/signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
end
