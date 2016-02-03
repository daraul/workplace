Rails.application.routes.draw do
  resources :todos
  root 'todos#index'
  
  get 'signup'  => 'users#new' 
  resources :users
  
  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
