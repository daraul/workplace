class TimeEntryPolicy < ApplicationPolicy
    attr_reader :user, :time_entry
    
    def initialize(user, job)
        @user = user
        @job = job
    end
    
    def index?
        user.has_role? :view_time_entries
    end
    
    def new?
        user.has_role? :create_time_entry
    end
    
    def show?
        user.has_role? :view_time_entry
    end
    
    def destroy?
        user.has_role? :delete_time_entry
    end
    
    def update?
        user.has_role? :update_time_entry
    end
end
