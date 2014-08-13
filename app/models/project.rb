class Project < ActiveRecord::Base
    validates :name, presence: true
    
    has_many :assignments
    has_many :employees, through: :assignments
    has_many :jobs
end
