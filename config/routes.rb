Rails.application.routes.draw do
  resources :routes, only: [:show]
  # Create a new sessions
  post 'sessions' => 'sessions#create'

  # Custom show to include api_key
  get '/sessions' => 'sessions#show' , as: :show

  # User Lists
  post '/sessions/add_to_list' => 'sessions#add_to_list', as: :add_to_list
  post '/sessions/remove_from_list' => 'sessions#remove_from_list', as: :remove_from_list
  get '/sessions/view_list' => 'sessions#view_list', as: :view_list

end
