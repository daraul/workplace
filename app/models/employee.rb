class Employee < ActiveRecord::Base
    validates :first_name, presence: true, length: { in: 2..15, message: "must be at least 2 to 15 characters long"}, format: { with: /[A-z\']{2,15}/, message: "must contain only letters or single quote" }
    validates :last_name, presence: true, length: { in: 2..15, message: "must be at least 2 to 15 characters long"}, format: { with: /[A-z\']{2,15}/, message: "must contain only letters or single quote" }
    
    has_many :jobs
    has_many :time_entries
    has_many :assignments
    has_many :projects, through: :assignments
    
    def full_name
        "#{first_name} #{last_name}"
    end
end
