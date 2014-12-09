class ProjectPolicy < ApplicationPolicy
    attr_reader :user, :project
    
    def initialize(user, project)
        @user = user
        @project = project
    end
    
    def index?
        true 
    end
    
    def new?
        true 
    end 
    
    def create?
        #Users should only be able to create projects in organizations they are a part of 
        user.organizations.any? { |organization| organization.id == @project.organization_id }
    end
    
    def show?
        #User should only be able to view projects that are assigned to their organizations
        user.organizations.any? { |organization| organization.id == @project.organization_id }
    end
    
    def destroy?
        user.has_role? :delete_project
    end
    
    def update?
        user.has_role? :update_project
    end
end
