Rails.application.routes.draw do
  root to: 'reservations#index'
  devise_for :users
  resources :users
  resources :reservations

  get 'dashboard/admin/:day_id' => 'reservations#dashboard', as: :admin_dashboard
  get 'timeblocks/:id' => 'timeblocks#reserve', as: :timeblocks_update
  put 'timeblocks/:id' => 'timeblocks#update'
  put 'reservations' => 'reservations#create', as: :create_reservations


end
