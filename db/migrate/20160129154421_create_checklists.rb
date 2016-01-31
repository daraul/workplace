class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
