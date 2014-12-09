module OrganizationsHelper

    def organization_params
        params.require(:organization).permit(:name)
    end

end
