class TimeEntriesController < ApplicationController
    include TimeEntriesHelper
    
    http_basic_authenticate_with name: "daraul", password: "1234", except: [:index, :show]
    
    def index
        @time_entries = TimeEntry.all
    end
    
    def new
        @time_entry = TimeEntry.new
    end
    
    def create
        @time_entry = TimeEntry.new(time_entry_params)
        @time_entry.save
        
        redirect_to jobs_path
        
        flash.notice = "Time entry created!"
    end
    
    def show
        @time_entry = TimeEntry.find(params[:id])
    end
    
    def destroy
        @time_entry = TimeEntry.find(params[:id])
        @time_entry.destroy
        
        redirect_to jobs_path
        
        flash.notice = "Time entry deleted!"
    end
    
    def update
        @time_entry = TimeEntry.find(params[:id])
        @time_entry.update(job_params)
        
        flash.notice = "Time entry updated!"
        
        redirect_to jobs_path
    end
end
