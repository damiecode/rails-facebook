Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: "posts#index"

  get 'notifications/destroy'
  
  resources :posts, except: [:edit, :update]
  resources :users
  resources :likes, only: [:create]
  resources :comments, only: [:create]
  resources :friendships, except: [:new, :edit, :show]

end
