module AssignmentsHelper
    
    def assignment_params
        params.require(:assignment).permit(:user_id, :project_id)
    end
    
end
