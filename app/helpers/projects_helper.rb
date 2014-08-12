module ProjectsHelper

    def project_params
        params.require(:project).permit(:name)
    end

end
