module TimeEntriesHelper
    def time_entry_params
        params.require(:time_entry).permit(:description, :start, :finish, :job_id, :user_id)
    end
end
