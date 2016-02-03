class ApplicationController < ActionController::Base
    before_action :require_user
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    helper_method :current_user 
    
    def current_user 
        @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    end
    
    def require_user 
        if !current_user
            redirect_to '/login' 
            flash.notice = "You need to log in or sign up."
        end 
    end
    
    def check_session
        if current_user 
            redirect_to root_path 
            flash.notice = "You're already logged in!"
        end 
    end 
    
    def check_registration 
        if User.all.include?(current_user)
            redirect_to root_path
            flash.notice = "You're already registered!"
        end 
    end 
end
