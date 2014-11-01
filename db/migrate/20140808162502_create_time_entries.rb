class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
        t.string :description
        t.datetime :start
        t.datetime :finish
        t.belongs_to :job
        t.belongs_to :user
        
        t.timestamps
    end
  end
end
