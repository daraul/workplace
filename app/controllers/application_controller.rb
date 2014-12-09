class ApplicationController < ActionController::Base
    include Pundit
    
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
    after_action :verify_authorized
    
    def user_not_authorized
        flash.notice = "You are not authorized to perform this action."
        redirect_to(authenticated_root_path)
    end
    
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
end
