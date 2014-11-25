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
        
        authorize @projects
        
        @projects = []
        
        current_user.organizations.each do |organization|
            organization.projects.each do |project|
                @projects << project
            end 
        end
    end
    
    def new
        @project = Project.new
        
        authorize @project
    end
    
    def create
        @project = Project.new(project_params)
        
        if @project.save
            redirect_to project_path(Project.last)
        
            flash.notice = "Project '#{@project.name}' created!"
        else
            render 'new'
            flash.notice = "Something was wrong with your input!"
        end
    end
    
    def show
        @project = Project.find(params[:id])
        
        authorize @project
        
        @jobs = @project.jobs
        
        @team = @project.users.uniq
    end
    
    def destroy
        @project = Project.find(params[:id])
        
        authorize @project
        
        @project.destroy
        
        flash.notice = "Project '#{@project.name}' deleted!"
        
        redirect_to projects_path
    end
    
    def update
        @project = Project.find(params[:id])
        
        authorize @project
        
        @project.update(project_params)
        
        flash.notice = "Project '#{@project.name}' updated!"
    end
end
