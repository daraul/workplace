class OrganizationsController < ApplicationController
    include OrganizationsHelper
    
    def index 
        @organizations = current_user.organizations
        
        authorize @organizations
    end
    
    def show 
        @organization = Organization.find(params[:id])
        
        authorize @organization
        
        @employees = @organization.users
        
        @projects = @organization.projects
    end
    
    def new 
        @organization = Organization.new
        
        authorize @organization
    end
    
    def create
        @organization = Organization.new(organization_params)
        
        if @organization.save 
            @organization.users << current_user
            
            redirect_to organization_path(Organization.last)
            
            flash.notice = "Organization '#{@organization.name}' created!"
        else 
            render 'new'
            
            flash.notice = "Something was wrong with your input!"
        end
    end
    
    #Lots of changes here. I hope I didn't screw it up. 
    def update 
        @organization = Organization.find(params[:id])
        
        #Rails kept throwing a param missing error, so I hacked this up to fix that 
        params[:organization] = { :name => @organization.name }
        
        if @organization.update(organization_params)
            if params.has_key?(:add_employee)
                @organization.add_employee(params[:add_employee])
            end
            
            redirect_to organization_path(@organization)
            
            flash.notice = "Organization updated!"
        else 
            render 'show'
        end 
    end 
    
    def destroy 
        @organization = Organization.find(params[:id])
        
        authorize @organization
        
        @organization.destroy
        
        flash.notice = "Organization '#{@organization.name}' deleted!"
        
        redirect_to organizations_path
    end 
    
end
