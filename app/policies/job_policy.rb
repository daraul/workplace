class JobPolicy < ApplicationPolicy
    attr_reader :user, :job
    
    def initialize(user, job)
        @user = user
        @job = job
    end
    
    def index?
        true
    end
    
    def new?
        true 
    end 
    
    def create?
        true 
    end
    
    def show?
        #Check the the user is a part of the organization that the job's project is assigned to 
        @user.organizations.any? { |organization| organization.id == @job.project.organization.id }
    end
    
    def destroy?
        user.has_role? :delete_job
    end
    
    def update?
        user.has_role? :update_job
    end
end
