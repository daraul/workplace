module EmployeesHelper
    
    def employee_params
        params.require(:user).permit(:first_name, :last_name)
    end
    
end
