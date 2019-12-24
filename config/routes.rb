Rails.application.routes.draw do

  root to: "posts#index"

  get '/', to: 'users/sign_in'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'users/registrations' }


  get 'notifications/destroy'
  resources :posts, except: [:edit, :update]
  resources :users
  resources :likes, only: [:create]
  resources :comments, only: [:create]
  resources :friendships, except: [:new, :edit, :show]
  resources :friendships do
    collection do
      patch :update
    end
  end
end
