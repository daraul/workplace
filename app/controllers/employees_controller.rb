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
    end
    
    def show
        @employee = User.find(params[:id])
        
        @jobs = @employee.jobs
        
        @projects = @employee.projects
    end
    
    def update
        @employee = User.find(params[:id])
        
        if @employee.update(employee_params)
            redirect_to employee_path(@employee)
            
            flash.notice = "Employee '#{@employee.full_name}' updated!"
        else
            render 'show'
            flash.notice = "Something was wrong with your input!"
        end
    end
end
