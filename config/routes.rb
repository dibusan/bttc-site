Rails.application.routes.draw do
  get 'carts/show'

  root to: 'visitors#home'

  # ------------------ Cart --------------------
  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  end
  # --------------------------------------------

  # -------------- Reservations ----------------
  resources :reservations, only: [:index, :new, :create]
  get 'reservations/table' => 'reservations#table', as: :table_reservation
  get 'reservations/lesson' => 'reservations#lesson', as: :lesson_reservation
  get 'dashboard/admin' => 'reservations#dashboard', as: :admin_dashboard
  delete 'reservations' => 'reservations#delete'
  # --------------------------------------------

  # ------------  User and Session -------------
  resources :users
  devise_for :users, skip: [:sessions]
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signin', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  get 'profile' => 'users#profile'
  post 'membership' => 'users#membership'
  # --------------------------------------------


  # ------------------ Products ----------------
  resources :products
  # --------------------------------------------
end
