class EmployeesController < ApplicationController
    include EmployeesHelper
    
    def index
        @employees = Employee.all
    end
    
    def new
        @employee = Employee.new
    end
    
    def create
        @employee = Employee.new(employee_params)
        
        if @employee.save
            redirect_to employee_path(@employee)
        
            flash.notice = "Employee '#{@employee.full_name}' created!"
        else
            render 'new'
            flash.notice = "Something was wrong with your input!"
        end
    end
    
    def show
        @employee = Employee.find(params[:id])
        
        @jobs = @employee.jobs
        
        @projects = @employee.projects
    end
    
    def destroy
        @employee = Employee.find(params[:id])
        @employee.destroy
        
        flash.notice = "Employee '#{@employee.first_name} #{@employee.last_name}' deleted!"
        
        redirect_to employees_path
    end
    
    def update
        @employee = Employee.find(params[:id])
        
        if @employee.update(employee_params)
            redirect_to employee_path(@employee)
            
            flash.notice = "Employee '#{@employee.first_name} #{@employee.last_name}' updated!"
        else
            render 'show'
            flash.notice = "Something was wrong with your input!"
        end
    end
end
