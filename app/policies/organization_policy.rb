class OrganizationPolicy < ApplicationPolicy
    attr_reader :user, :organization 
    
    def initialize(user, organization)
        @user = user 
        @organization = organization
    end 
    
    def index? 
        true 
    end 
    
    def new?
        true 
    end 
    
    #Check whether the user belongs to the organization 
    def show?
        user.organizations.any? { |organization| organization[:id] == @organization.id }
    end 
    
    def create?
        true 
    end 
    
    def update?
        #This should only work if the user CREATED the organization 
        user.has_role? "created_organization_#{@organization.id}"
    end 
    
    def destroy?
        user.has_role? :delete_organization
    end 
    
    def update?
        user.has_role? :update_organization
    end
end
