Rails.application.routes.draw do
   devise_for :users, controllers: { registrations: 'users/registrations' }
   resources :posts, only: [:create, :destroy, :index, :show] 
end
