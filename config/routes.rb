Rails.application.routes.draw do

  root 'static_pages#index'

  # Sessions
  get 'sessions' => 'sessions#show'
  post 'sessions' => 'sessions#create'
  patch 'sessions/update' => 'sessions#update'

  # Routes
  get 'routes' => 'routes#show'

end
