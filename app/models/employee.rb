class Employee < ActiveRecord::Base
    has_many :jobs
end
