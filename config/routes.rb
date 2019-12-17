Rails.application.routes.draw do
   devise_for :users, controllers: { registrations: 'users/registrations' }
   root to: "home#page"

   resources :posts, only: [:create, :destroy, :index, :show,:new]
   resources :users
end
