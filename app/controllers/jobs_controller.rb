class JobsController < ApplicationController
    include JobsHelper
    
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
        @jobs = current_user.jobs
    end
    
    def new
        @job = Job.new
        @colleagues = current_user.users.uniq
        @projects = []
        
        current_user.organizations.each do |organization|
            organization.projects.each do |project|
                @projects << project 
            end 
        end 
    end
    
    def create
        @job = Job.new(job_params)
        
        #The project and employee assigned to the new job must both be a part of the same organization
        #I need to find a way to get this error and create my own error message for it
        project = Project.find(params[:job][:project_id])
        employee = User.find(params[:job][:user_id])
        
        if @job.save && employee.organizations.any? { |organization| organization[:id] == project.organization.id }
            redirect_to job_path(Job.last)
            
            flash.notice = "Job '#{@job.title}' created!"
        else
            render 'new'
            flash.notice = "Something was wrong with your input!"
        end
    end
    
    def show
        @job = Job.find(params[:id])
        
        @employee = User.find(@job.user_id)
        
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
