class UsersController < ApplicationController
    skip_before_filter :require_user, only: [:new, :create]
    before_action :check_registration, only: [:new, :create]
    
    def new 
        @user = User.new 
    end 
    
    def create 
        @user = User.new(user_params) 
        
        if @user.save 
            session[:user_id] = @user.id 
            redirect_to '/' 
        else 
            render :new
        end 
    end  
    
    def show 
        @user = current_user
    end 
    
    def update 
        @user = User.find(params[:id])
        
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to profile_path, notice: 'Your information was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end 

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end  
end
