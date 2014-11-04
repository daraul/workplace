class Assignment < ActiveRecord::Base
    belongs_to :project
    belongs_to :user

    # Make sure the assignment is unique.
    # ie, the same user cannot be assigned to one project twice.
    validates_uniqueness_of :user, scope: :project, message: "is already assigned to this project!"
end
