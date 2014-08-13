module JobsHelper

    def job_params
        params.require(:job).permit(:title, :description, :complete, :employee_id, :project_id)
    end
    
end
