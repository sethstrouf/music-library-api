Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %w[index show]
      resources :current_user, only: %w[index]
      resources :works, only: %w[index create show update destroy]
      resources :libraries, only: %w[index create show update destroy]
      resources :library_works, only: %w[index create show update destroy]
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
