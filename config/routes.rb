Rails.application.routes.draw do
  resources :todos
  root 'todos#index'
  
  get 'signup'  => 'users#new' 
  get 'profile' => 'users#show'
  
  resources :users, only: [:create, :update]
  
  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
