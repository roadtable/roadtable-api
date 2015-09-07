Rails.application.routes.draw do
  resources :sessions, only: [:create]

  # route for testing
  root 'sessions#test'

  # custom show to include api_key
  get '/sessions' => 'sessions#show' , as: :show

  # custom route to add a restaurant to the session list
  post '/sessions/add_to_list' => 'sessions#add_to_list', as: :add_to_list

end
