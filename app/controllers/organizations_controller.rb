class OrganizationsController < ApplicationController
    include OrganizationsHelper
    
    def index 
        @organizations = current_user.organizations
    end
    
    def show 
        @organization = Organization.find(params[:id])
        
        @employees = @organization.users
        
        @projects = @organization.projects
    end
    
    def new 
        @organization = Organization.new
    end
    
    def create
        @organization = Organization.new(organization_params)
        
        if @organization.save 
            redirect_to organization_path(Organization.last)
            
            flash.notice = "Organization '#{@organization.name}' created!"
        else 
            render 'new'
            
            flash.notice = "Something was wrong with your input!"
        end
    end
    
end
