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
        redirect_to '/login' unless current_user 
        flash.notice = "You need to log in or sign up."
    end
end
