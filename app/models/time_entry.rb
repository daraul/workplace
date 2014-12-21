class TimeEntry < ActiveRecord::Base
    validates :description, presence: true, length: { in: 5..500, message: "must be kept between 5 to 500 characters" }, format: { with: /[A-z0-9\.\\\/\(\)\?\$\&\,\s]{5,500}/, message: "can only use upper & lower case letters, numbers and these special characters: . \ / ( ) ? $ & ," }
    validates :start, presence: true, format: { with: /\d+/, message: "can only be a number."  }
    validates :finish, presence: true, format: { with: /\d+/, message: "can only be a number."  }
    validates :job_id, presence: true, format: { with: /\d+/, message: "can only be a number."  }
    validates :user_id, presence: true, format: { with: /\d+/, message: "can only be a number."  }
    
    belongs_to :job
    belongs_to :user
end
