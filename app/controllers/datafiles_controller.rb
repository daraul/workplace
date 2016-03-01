class DatafilesController < ApplicationController
    def destroy
        @datafile = Datafile.find(params[:id])
        
        @datafile.destroy
        
        respond_to do |format|
            format.html { redirect_to :back, notice: 'File was sucessfully deleted.' }
        end
    end
end
