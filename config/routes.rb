Rails.application.routes.draw do
  root to: 'visitors#home'
  get 'reservations/calendar' => 'reservations#calendar', as: :calendar

  devise_for :users, skip: [:sessions]

  devise_scope :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signin', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :users

  resources :reservations, only: [:index, :new, :create]

  get 'dashboard/admin' => 'reservations#dashboard', as: :admin_dashboard
  delete 'reservations' => 'reservations#delete'

end
