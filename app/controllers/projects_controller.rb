class ProjectsController < ApplicationController
    include ProjectsHelper
    
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
        @projects = Project.all
    end
    
    def new
        @project = Project.new
    end
    
    def create
        @project = Project.new(project_params)
        
        if @project.save
            redirect_to projects_path
        
            flash.notice = "Project '#{@project.name}' created!"
        else
            render 'new'
            flash.notice = "Something was wrong with your input!"
        end
    end
    
    def show
        @project = Project.find(params[:id])
        
        @jobs = @project.jobs
        
        @employees = @project.users
        
        @assignments = @project.assignments
    end
    
    def destroy
        @project = Project.find(params[:id])
        @project.destroy
        
        flash.notice = "Project '#{@project.name}' deleted!"
        
        redirect_to projects_path
    end
    
    def update
        @project = Project.find(params[:id])
        @project.update(project_params)
        
        flash.notice = "Project '#{@project.name}' updated!"
    end
end
