class EmployeesController < ApplicationController
    include EmployeesHelper
    
    before_filter :is_admin
    
    def is_admin
        if user_signed_in?
            true
        else
            flash.notice = "You need to log in to do that!"
        
            redirect_to unauthenticated_root_path
        end
    end
    
    def index
        @employees = User.all
        
        @colleagues = current_user.users.uniq
        
        authorize @employees
    end
    
    def show
        @employee = User.find(params[:id])
        
        authorize @employee
        
        @jobs = @employee.jobs
        
        @projects = @employee.projects.uniq
        
        @roles = []
        
        @employee.roles.each do |role|
            @roles << role.name
        end
    end
    
    def update 
        @employee = User.find(params[:id])
        
        authorize @employee
        
        if @employee.update(employee_params)
            @employee.add_role params[:user][:roles]
            
            redirect_to employee_path(@employee)
            
            flash.notice = "Employee '#{@employee.full_name}' updated!"
        else
            render 'show'
        end
    end
end
