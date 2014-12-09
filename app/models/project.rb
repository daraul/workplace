class Project < ActiveRecord::Base
    validates :name, presence: true, length: { in: 6..35, message: "must be 6 to 35 characters long"}, format: { with: /[A-z0-9\.\\\/\(\)\?\$\&\s]{6,35}/, message: "can only use upper & lower case letters, numbers and these special characters: . \ / ( ) ? $ &" }
    validates :organization, presence: true
    
    has_many :jobs, dependent: :destroy
    has_many :users, through: :jobs
    belongs_to :organization
end
