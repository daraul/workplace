class Project < ActiveRecord::Base
    validates :name, presence: true
    validates :name, length: { in: 6..20 }
    validates :name, format: { with: /[\w\!\@\#\$\%\(\)\|\\\/\<\>\&\s]+/, message: "That will not work" }
    
    has_many :assignments
    has_many :employees, through: :assignments
    has_many :jobs
end
