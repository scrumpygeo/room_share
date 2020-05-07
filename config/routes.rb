Rails.application.routes.draw do
  # get 'rooms/index'
  devise_for :users
  root to: 'pages#home'
  resources :rooms do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :show, :destroy, :update] 
  resources :dashboards, only: [:index]
end
