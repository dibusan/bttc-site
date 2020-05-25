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


  get 'dashboard/admin/:day_id' => 'reservations#dashboard', as: :admin_dashboard
  get 'timeblocks/:id' => 'timeblocks#reserve', as: :timeblocks_update
  put 'timeblocks/:id' => 'timeblocks#update'

  get 'reservations' => 'reservations#index', as: :reservations
  put 'reservations' => 'reservations#create'

end
