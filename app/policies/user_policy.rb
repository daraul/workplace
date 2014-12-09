class UserPolicy < ApplicationPolicy
    attr_reader :user
    
    def initialize(user, employee)
        @user = user
        @employee = employee
    end
    
    def index?
        true 
    end
    
    def show?
        #Show the current user their colleagues
        user.users.any? { |colleague| colleague[:id] == @employee.id }
    end
    
    def update?
        #Users should be able to update themselves only. I'll add something more to this later on maybe
        @user.id == @employee.id 
    end
end
