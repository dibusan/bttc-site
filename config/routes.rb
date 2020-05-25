Rails.application.routes.draw do
  root to: 'reservations#calendar'
  devise_for :users, skip: [:sessions]

  devise_scope :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signin', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :users

  get '/user' => "reservations#calendar", :as => :user_root


  # get 'timeblocks/:id' => 'timeblocks#reserve', as: :timeblocks_update
  # put 'timeblocks/:id' => 'timeblocks#update'

  resources :reservations, only: [:index, :new, :create, :delete]
  get 'dashboard/admin/:day_id' => 'reservations#dashboard', as: :admin_dashboard
  # get 'reservations' => 'reservations#index', as: :reservations
  # put 'reservations' => 'reservations#create'
  # delete 'reservations' => 'reservations#delete'
  # get 'reservations/new' => 'reservations#new', as: :reservations

end
