class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
        t.belongs_to :employee
        t.belongs_to :project
        
        t.timestamps
    end
  end
end
