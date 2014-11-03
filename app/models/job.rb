class Job < ActiveRecord::Base
    resourcify
    
    validates :title, presence: true, length: { in: 5..60, message: "must be kept between 5 to 60 characters" }, format: { with: /[A-z0-9\.\\\/\(\)\?\$\&\s]{5,60}/, message: "can only use upper & lower case letters, numbers and these special characters: . \ / ( ) ? $ &" }
    validates :description, presence: true, length: { in: 5..500, message: "must be kept between 5 to 500 characters" }, format: { with: /[A-z0-9\.\\\/\(\)\?\$\&\,\s]{5,500}/m, message: "can only use upper & lower case letters, numbers and these special characters: . \ / ( ) ? $ & ," }
    validates :user_id, presence: true
    validates :project_id, presence: true
    
    belongs_to :user
    belongs_to :project
    has_many :time_entries
end
