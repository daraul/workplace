module ProjectsHelper

    def project_params
        params.require(:project).permit(:name, :organization_id)
    end

end
