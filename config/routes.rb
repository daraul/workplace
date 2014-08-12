Rails.application.routes.draw do
    root to: 'jobs#index'
    
    resources :jobs do
        resources :time_entries
    end
    
    resources :employees do
        resources :time_entries
    end
    
    resources :time_entries
    
    resources :projects do
        resources :assignments
    end
    
    resources :assignments
end
