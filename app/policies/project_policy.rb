class ProjectPolicy < ApplicationPolicy
    attr_reader :user, :project
    
    def initialize(user, project)
        @user = user
        @project = project
    end
    
    def index?
        user.has_role? :view_projects
    end
    
    def create?
        #Users should only be able to create projects in organizations they are a part of 
        user.organizations.any? { |organization| organization.id == @project.organization_id }
    end
    
    def show?
        user.has_role? :view_project
    end
    
    def destroy?
        user.has_role? :delete_project
    end
    
    def update?
        user.has_role? :update_project
    end
end
