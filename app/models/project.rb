class Project < ActiveRecord::Base
    has_many :assignments
    has_many :employees, through: :assignments
    has_many :jobs
end
