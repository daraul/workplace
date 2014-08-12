class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
        t.string :title
        t.string :description
        t.boolean :complete
        t.belongs_to :employee
        t.belongs_to :project
        
        t.timestamps
    end
  end
end
