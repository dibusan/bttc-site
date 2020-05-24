Rails.application.routes.draw do
  root to: 'reservations#index'
  devise_for :users
  resources :users
  resources :reservations

  get 'timeblocks/:id' => 'timeblocks#reserve', as: :timeblocks_update
  put 'timeblocks/:id' => 'timeblocks#update'

end
