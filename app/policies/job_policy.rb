class JobPolicy < ApplicationPolicy
    attr_reader :user, :job
    
    def initialize(user, job)
        @user = user
        @job = job
    end
    
    def index?
        user.has_role? :view_jobs
    end
    
    def create?
        user.has_role? :create_job
    end
    
    def show?
        user.has_role? :view_job
    end
    
    def destroy?
        user.has_role? :delete_job
    end
    
    def update?
        user.has_role? :update_job
    end
end
