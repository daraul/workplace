class Organization < ActiveRecord::Base
    validates :name, presence: true

    has_and_belongs_to_many :users
    has_many :projects, dependent: :destroy
    
    #Just a method to add an employee. The form won't work without this.
    def add_employee(email)
        employee = User.find_by(email: email)
        
        self.users << employee
    end 

end
