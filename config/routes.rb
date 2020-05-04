Rails.application.routes.draw do
  get 'rooms/index'
  devise_for :users
  root to: 'pages#home'
  resources :rooms, only: [:index, :create, :update, :new, :destroy ] do
    resources :bookings, shallow: true
  end
  resources :dashboards, only: [:index]
end
