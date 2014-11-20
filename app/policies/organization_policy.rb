class OrganizationPolicy < ApplicationPolicy
    attr_reader :user, :organization 
    
    def initialize(user, organization)
        @user = user 
        @organization = organization
    end 
    
    def index? 
        user.has_role? :view_organizations
    end 
    
    def new?
        user.has_role? :create_organization
    end 
    
    def show?
        user.has_role? :view_organization
    end 
    
    def destroy?
        user.has_role? :delete_organization
    end 
    
    def update?
        user.has_role? :update_organization
    end
end
