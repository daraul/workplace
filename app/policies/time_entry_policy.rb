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
        #Users should only be able to delete time entries for jobs they are assigned to 
        @user.jobs.any? { |job| job.id == @time_entry.job.id }
    end
end
