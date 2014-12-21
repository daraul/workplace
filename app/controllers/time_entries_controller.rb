class TimeEntriesController < ApplicationController
    include TimeEntriesHelper
    
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
        @time_entries = TimeEntry.all
        
        authorize @time_entrys 
    end
    
    def new
        @time_entry = TimeEntry.new
        
        authorize @time_entry
        
        @colleagues = current_user.users.uniq
        
        @jobs = current_user.jobs
    end
    
    def create
        @time_entry = TimeEntry.new(time_entry_params)
        
        authorize @time_entry
        
        @colleagues = current_user.users.uniq
        
        @jobs = current_user.jobs
        
        #The time entry should only be assigned if the user that assigned it is assigned to that job 
        if current_user.jobs.any? { |job| job.id.to_s == params[:time_entry][:job_id] } && @time_entry.save
            
            redirect_to job_path(params[:time_entry][:job_id])
            
            flash.notice = "Time entry created!"
        else 
            render 'new'
            flash.notice = "Something was wrong with your input!"
        end 
    end
    
    def show
        @time_entry = TimeEntry.find(params[:id])
        
        authorize @time_entry
    end
    
    def destroy
        @time_entry = TimeEntry.find(params[:id])
        
        authorize @time_entry
        
        job_id = @time_entry.job_id
        
        @time_entry.destroy
        
        redirect_to job_path(job_id)
        
        flash.notice = "Time entry deleted!"
    end
end
