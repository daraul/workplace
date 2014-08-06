module EmployeesHelper
    
    def employee_params
        params.require(:employee).permit(:first_name, :last_name)
    end
    
end
