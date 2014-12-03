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
        #Show the current user only pages their authorized to see via roles
        user.has_role? "view_employee_#{@employee.id}"
    end
    
    def update?
        user.has_role? :update_employee
    end
end
