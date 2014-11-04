class JobPolicy < ApplicationPolicy
    attr_reader :user, :job
    
    def initialize(user, job)
        @user = user
        @job = job
    end
    
    def index?
        user.has_role? :view_jobs
    end
end
