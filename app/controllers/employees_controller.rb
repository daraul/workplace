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
        @employee.save
        
        redirect_to employees_path
        
        flash.notice = "Employee '#{@employee.first_name} #{@employee.last_name}' created!"
    end
    
    def show
        @employee = Employee.find(params[:id])
    end
    
    def destroy
        @employee = Employee.find(params[:id])
        @employee.destroy
        
        flash.notice = "Employee '#{@employee.first_name} #{@employee.last_name}' deleted!"
        
        redirect_to employees_path
    end
    
    def update
        @employee = Employee.find(params[:id])
        @employee.update(employee_params)
        
        flash.notice = "Employee '#{@employee.first_name} #{@employee.last_name}' updated!"
        
        redirect_to employees_path
    end
end
