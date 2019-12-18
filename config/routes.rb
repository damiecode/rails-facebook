Rails.application.routes.draw do
   devise_for :users, controllers: { registrations: 'users/registrations' }
   root to: "posts#index"

   resources :posts, only: [:create, :destroy, :index, :show,:new]
   resources :users
   resources :comments, only: [:create, :destroy, :new]
end
