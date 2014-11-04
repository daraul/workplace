class ProjectPolicy < ApplicationPolicy
    attr_reader :user, :project
    
    def initialize(user, project)
        @user = user
        @project = project
    end
    
    def index?
        user.has_role? :view_projects
    end
    
    def new?
        user.has_role? :create_project
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
