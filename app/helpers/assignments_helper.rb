module AssignmentsHelper
    
    def assignment_params
        params.require(:assignment).permit(:employee_id, :project_id)
    end
    
end
