class UserPolicy < ApplicationPolicy
    attr_reader :user
    
    def initialize(user, employee)
        @user = user
        @employee = employee
    end
    
    def index?
        user.has_role? :view_employees
    end
    
    def show?
        user.has_role? :view_employee
    end
end
