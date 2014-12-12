class DashboardPolicy < ApplicationPolicy
    attr_reader :user, :dashboard 
    
    def initialize(user, dashboard)
        @user = user
        @dashboard = dashboard 
    end
    
    def index?
        true 
    end 
end
