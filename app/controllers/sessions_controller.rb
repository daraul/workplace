class SessionsController < ApplicationController
    skip_before_filter :require_user, only: [:new, :create]
    before_action :check_session, only: [:new, :create]
    
    def new
    end
    
    def create
        @user = User.find_by_email(params[:session][:email])
        
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            redirect_to '/'
        else
            redirect_to '/login'
            flash.notice = "There was a problem with your information"
        end 
    end
    
    def destroy 
        session[:user_id] = nil 
        redirect_to '/login' 
    end
end
