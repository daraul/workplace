class JobsController < ApplicationController
    def index
        @jobs = Job.all
    end
    
    def new
        @job = Job.new
    end
    
    def create
        @job = Job.new
        @job.title = params[:job][:title]
        @job.description = params[:job][:description]
        @job.complete = params[:job][:complete]
        @job.save
        
        redirect_to jobs_path
        
        flash.notice = "Job '#{@job.title}' created!"
    end
    
    def show
        @job = Job.find(params[:id])
    end
    
    def destroy
        @job = Job.find(params[:id])
        @job.destroy
        
        flash.notice = "Job '#{@job.title}' deleted!"
        
        redirect_to jobs_path
    end
end
