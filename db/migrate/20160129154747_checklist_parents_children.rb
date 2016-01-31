class ChecklistParentsChildren < ActiveRecord::Migration
  def change
      create_table :checklists_checklists, id: false do |t|
          t.integer :parent_id, index: true 
          t.integer :child_id, index: true 
      end 
  end
end
