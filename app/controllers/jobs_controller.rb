class JobsController < ApplicationController
    include JobsHelper
    
    http_basic_authenticate_with name: "user", password: "1234", except: [:index, :show]
    
    def index
        @jobs = Job.all
    end
    
    def new
        @job = Job.new
    end
    
    def create
        @job = Job.new(job_params)
        
        if @job.save
            redirect_to jobs_path
            
            flash.notice = "Job '#{@job.title}' created!"
        else
            render 'new'
            flash.notice = "Something was wrong with your input!"
        end
    end
    
    def show
        @job = Job.find(params[:id])
        
        @employee = Employee.find(@job.employee_id)
        
        @time_entries = @job.time_entries
        
        @project = @job.project
    end
    
    def destroy
        @job = Job.find(params[:id])
        @job.destroy
        
        flash.notice = "Job '#{@job.title}' deleted!"
        
        redirect_to jobs_path
    end
    
    def update
        @job = Job.find(params[:id])
        
        if @job.update(job_params)
            redirect_to job_path(@job)
            
            flash.notice = "Job '#{@job.title}' updated!"
        else
            render 'show'
        end
    end
end
