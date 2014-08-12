class ProjectsController < ApplicationController
    include ProjectsHelper
    
    def index
        @projects = Project.all
    end
    
    def new
        @project = Project.new
    end
    
    def create
        @project = Project.new(project_params)
        @project.save
        
        redirect_to projects_path
        
        flash.notice = "Project '#{@project.name}' created!"
    end
    
    def show
        @project = Project.find(params[:id])
        
        @jobs = @project.jobs
        
        @employees = @project.employees
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
