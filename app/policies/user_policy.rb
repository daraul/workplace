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
        #Show the current user their colleagues
        user.users.any? { |colleague| colleague[:id] == @employee.id }
    end
    
    def update?
        user.has_role? :update_employee
    end
end
