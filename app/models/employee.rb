class Employee < ActiveRecord::Base
    has_many :jobs
    has_many :time_entries
    has_many :assignments
    has_many :projects, through: :assignments
    
    def full_name
        "#{first_name} #{last_name}"
    end
end
