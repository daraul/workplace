class JobsController < ApplicationController
    def index
        @jobs = Job.all
    end
    
    def new
        @job = Job.new
    end
    
    def create
        @job = Job.new
        @job.title = params[:job][:title]
        @job.save
        
        redirect_to jobs_path(@jobs)
    end
end
