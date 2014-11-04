class AssignmentsController < ApplicationController
    include AssignmentsHelper
    
    before_filter :is_admin
    
    def is_admin
        if user_signed_in?
            true
        else
            flash.notice = "You need to log in to do that!"
        
            redirect_to unauthenticated_root_path
        end
    end
    
    def new
        @assignment = Assignment.new
        
        authorize @assignment
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
