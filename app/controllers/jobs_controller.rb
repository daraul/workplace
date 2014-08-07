class JobsController < ApplicationController
    include JobsHelper
    
    def index
        @jobs = Job.all
    end
    
    def new
        @job = Job.new
    end
    
    def create
        @job = Job.new(job_params)
        @job.save
        
        redirect_to jobs_path
        
        flash.notice = "Job '#{@job.title}' created!"
    end
    
    def show
        @job = Job.find(params[:id])
        
        @employee = @job.employee
    end
    
    def destroy
        @job = Job.find(params[:id])
        @job.destroy
        
        flash.notice = "Job '#{@job.title}' deleted!"
        
        redirect_to jobs_path
    end
    
    def update
        @job = Job.find(params[:id])
        @job.update(job_params)
        
        flash.notice = "Job '#{@job.title}' updated!"
        
        redirect_to job_path(@job)
    end
end
