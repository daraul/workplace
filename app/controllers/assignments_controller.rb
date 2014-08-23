class AssignmentsController < ApplicationController
    include AssignmentsHelper
    
    def new
        @assignment = Assignment.new
    end
    
    def create
        @assignment = Assignment.new(assignment_params)
        
        # Verify that the assignment saved correctly and without errors.
        # If not, render the page again and display the errors.
        if @assignment.save
            flash.notice = "Job assigned!"
            redirect_to projects_path
        else
            render 'new'
        end
    end
end
