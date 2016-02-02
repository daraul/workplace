class TodoParentsChildren < ActiveRecord::Migration
    def change
      create_table :todos_todos, id: false do |t|
          t.integer :parent_id, index: true 
          t.integer :child_id, index: true 
      end 
    end
end
