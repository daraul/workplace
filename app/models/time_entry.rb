class TimeEntry < ActiveRecord::Base
    validates :description, presence: true, length: { in: 5..500, :message => "must be kept between 5 to 500 characters" }, format: { with: /^[A-z0-9\.\\\/\(\)\?\$\&\,\s]{5,500}$/, :multiline => true, :message => "can only use upper & lower case letters, numbers and these special characters: . \ / ( ) ? $ & ," }
    validates :start, presence: true, format: { :with => /\A((19[7-9][0-9])|(2[0-9][0-9][0-9]))\-((0[1-9])|(1[0-2]))\-(([0-2][1-9])|(3[0-1]))\s(([0-1][0-9])|(2[0-4]))\:([0-5][0-9])\:([0-5][0-9])\sUTC\z/, :message => "was formatted incorrectly!" }
    validates :finish, presence: true, format: { :with => /\A((19[7-9][0-9])|(2[0-9][0-9][0-9]))\-((0[1-9])|(1[0-2]))\-(([0-2][1-9])|(3[0-1]))\s(([0-1][0-9])|(2[0-4]))\:([0-5][0-9])\:([0-5][0-9])\sUTC\z/, :message => "was formatted incorrectly!" }
    validates :job_id, presence: true, format: { :with => /\d+/, :message => "can only be a number."  }
    validates :user_id, presence: true, format: { :with => /\d+/, :message => "can only be a number."  }
    
    validate :start_is_before_finish, on: :create
    
    def start_is_before_finish
        if (start && finish) && finish < start
            errors.add(:time_entry, "finish cannot be before start!")
        end 
    end 
    
    belongs_to :job
    belongs_to :user
end
