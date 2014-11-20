class User < ActiveRecord::Base
    rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
         
    def full_name
        "#{first_name} #{last_name}"
    end
         
    has_many :jobs
    has_many :time_entries
    has_many :projects, through: :jobs
    has_and_belongs_to_many :organizations
end
