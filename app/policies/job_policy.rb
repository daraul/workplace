class JobPolicy < ApplicationPolicy
    attr_reader :user, :job
    
    def initialize(user, job)
        @user = user
        @job = job
    end
    
    def index?
        user.has_role? :create_job
    end
end
