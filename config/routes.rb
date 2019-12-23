Rails.application.routes.draw do
   get 'notifications/destroy'
   devise_for :users, controllers: { registrations: 'users/registrations' }
   root to: "posts#index"

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
