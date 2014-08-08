class Job < ActiveRecord::Base
    has_one :employee
    has_many :time_entries
end
