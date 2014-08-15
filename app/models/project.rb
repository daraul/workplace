class Project < ActiveRecord::Base
    validates :name, presence: true
    validates :name, length: { in: 6..20 }
    validates :name, format: { with: /[\w\!\@\#\$\%\(\)\|\\\/\<\>\&\s]+/, message: "Please only use upper & lower case letters, numbers and these special characters: !, @, #, $, %, (, ), |, \, /, <, > and &" }
    
    has_many :assignments
    has_many :employees, through: :assignments
    has_many :jobs
end
