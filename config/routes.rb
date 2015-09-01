Rails.application.routes.draw do
  resources :sessions, only: [:index, :show, :create]
end
