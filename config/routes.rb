Rails.application.routes.draw do
  resources :sessions, only: [:index, :show, :create]

  # route for testing
  root 'sessions#test'
end
