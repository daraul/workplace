class Employee < ActiveRecord::Base
    has_many :jobs
    has_many :time_entries
    
    def full_name
        "#{first_name} #{last_name}"
    end
end
