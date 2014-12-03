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
        user.has_role? :create_project
        
        #This should also have a way to check that the user is associated with the organization and that they have the right roles within that organization.
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
