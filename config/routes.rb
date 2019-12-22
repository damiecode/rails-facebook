Rails.application.routes.draw do
   get 'notifications/destroy'
   devise_for :users, controllers: { registrations: 'users/registrations' }
   root to: "posts#index"

   resources :posts, only: [:create, :destroy, :index, :show,:new]
   resources :users
   resources :likes, only: [:create]
   resources :comments, only: [:create]
   resources :friendships, only: [:create, :destroy, :index]
   resources :friendships do
    collection do
      patch :update
    end
  end
end
