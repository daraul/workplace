class AssignmentsController < ApplicationController
    include AssignmentsHelper
    
    def new
        @assignment = Assignment.new
    end
    
    def create
        @assignment = Assignment.new(assignment_params)
        @assignment.save
        
        redirect_to projects_path
        
        flash.notice = "Job assigned!"
    end
end
