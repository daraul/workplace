class TimeEntryPolicy < ApplicationPolicy
    attr_reader :user, :time_entry
    
    def initialize(user, time_entry)
        @user = user
        @time_entry = time_entry
    end
    
    def index?
        user.has_role? :view_time_entries
    end
    
    def create?
        user = User.find(@time_entry.user_id)
        user.jobs.any? { |job| job.id == @time_entry.job.id }
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
