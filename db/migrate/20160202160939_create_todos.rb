class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description, :default => ""
      t.datetime :due, :null => false
      t.boolean :completed, :default => false
      t.belongs_to :user, index:true 

      t.timestamps null: false
    end
  end
end
