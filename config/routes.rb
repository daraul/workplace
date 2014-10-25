Rails.application.routes.draw do
    devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :skip => :registrations
    
    devise_scope :user do
        authenticated :user do
            root 'jobs#index', as: :authenticated_root
        end
        
        unauthenticated do
            root "devise/sessions#new", as: :unauthenticated_root
        end
    end
    
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
