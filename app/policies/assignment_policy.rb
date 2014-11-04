class AssignmentPolicy < ApplicationPolicy
    attr_reader :user, :assignment
    
    def initialize(user, assignment)
        @user = user
        @assignment = assignment
    end
    
    def new?
        user.has_role? :create_assignment
    end
end
