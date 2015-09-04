Rails.application.routes.draw do
  resources :sessions, only: [:index, :create]

  # route for testing
  root 'sessions#test'

  # custom show to include api_key
  get '/sessions' => 'sessions#show' , as: :show

end
