class OrganizationsController < ApplicationController
    
    def index 
        @organizations = current_user.organizations
    end
    
    def show 
        @organization = Organization.find(params[:id])
        
        @employees = @organization.users
    end
    
end
