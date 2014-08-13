class Job < ActiveRecord::Base
    validates :title, presence: true
    
    belongs_to :employee
    belongs_to :project
    has_many :time_entries
end
