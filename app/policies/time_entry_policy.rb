class TimeEntryPolicy < ApplicationPolicy
    attr_reader :user, :time_entry
    
    def initialize(user, time_entry)
        @user = user
        @time_entry = time_entry
    end
    
    def index?
        true 
    end
    
    def create?
        true 
    end 
    
    def show?
        true 
    end
    
    def destroy?
        user.has_role? :delete_time_entry
    end
    
    def update?
        user.has_role? :update_time_entry
    end
end
