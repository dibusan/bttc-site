Rails.application.routes.draw do
  root to: 'visitors#home'
  get 'reservations/table' => 'reservations#table', as: :table_reservation
  get 'reservations/lesson' => 'reservations#lesson', as: :lesson_reservation

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
