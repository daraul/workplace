class TimeEntry < ActiveRecord::Base
    belongs_to :job
    has_one :employee
end
