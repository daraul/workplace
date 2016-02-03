class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.boolean :completed
      t.belongs_to :user, index:true 

      t.timestamps null: false
    end
  end
end
