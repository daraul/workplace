class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
        t.string :name
        t.belongs_to :organization
        
        t.timestamps
    end
  end
end
