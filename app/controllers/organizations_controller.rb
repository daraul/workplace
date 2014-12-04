class OrganizationsController < ApplicationController
    include OrganizationsHelper
    
    def index 
        @organizations = current_user.organizations
    end
    
    def show 
        @organization = Organization.find(params[:id])
        
        authorize @organization 
        
        @employees = @organization.users.uniq
        
        @projects = @organization.projects
    end
    
    def new 
        @organization = Organization.new
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
        
        @organization.destroy
        
        flash.notice = "Organization '#{@organization.name}' deleted!"
        
        redirect_to organizations_path
    end 
    
    def remove_employee
        @organization = Organization.find(params[:organization_id])
        
        @organization.users.delete(params[:employee_id])
            
        #I'd prefer for this to send the user back to the organization path, but right now that throws an error. 
        #Maybe later I can fix this functionality
        redirect_to organizations_path
    end 
    
end
