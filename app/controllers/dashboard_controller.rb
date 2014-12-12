class DashboardController < ApplicationController
    include DashboardHelper
    
    before_filter :is_admin
    
    def is_admin
        if user_signed_in?
            true
        else
            flash.notice = "You need to log in to do that!"
        
            redirect_to unauthenticated_root_path
        end
    end
    
    def index
        #Only show the user uncompleted jobs 
        @jobs = current_user.jobs.select { |key, value| key.complete == false }
        
        #Show the users currently assigned projects
        @projects = current_user.projects.uniq 
    end 
end
