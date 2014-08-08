class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
        t.string :description
        t.datetime :start
        t.datetime :finish
        t.references :job
        t.references :employee
        
        t.timestamps
    end
  end
end
